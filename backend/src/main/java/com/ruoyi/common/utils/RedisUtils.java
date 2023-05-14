package com.ruoyi.common.utils;

import cn.hutool.core.collection.IterUtil;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.utils.spring.SpringUtils;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.*;

import java.time.Duration;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.function.Consumer;

/**
 * redis 工具类
 *
 * @author hash
 * @version 3.1.0 新增
 */
@Slf4j
@NoArgsConstructor(access = AccessLevel.PRIVATE)
@SuppressWarnings(value = {"unchecked", "rawtypes"})
public class RedisUtils {

    private static final RedissonClient CLIENT = SpringUtils.getBean(RedissonClient.class);

    /**
     * 获取锁
     *
     * @param lock 锁名称
     * @return 锁实例
     */
    public static RLock getRLock(String lock) {
        return CLIENT.getLock(lock);
    }

    /**
     * 限流
     *
     * @param key          限流key
     * @param rateType     限流类型
     * @param rate         速率
     * @param rateInterval 速率间隔
     * @return -1 表示失败
     */
    public static long rateLimiter(String key, RateType rateType, int rate, int rateInterval) {
        RRateLimiter rateLimiter = CLIENT.getRateLimiter(key);
        rateLimiter.trySetRate(rateType, rate, rateInterval, RateIntervalUnit.SECONDS);
        if (rateLimiter.tryAcquire()) {
            return rateLimiter.availablePermits();
        } else {
            return -1L;
        }
    }

    /**
     * 获取客户端实例
     */
    public static RedissonClient getClient() {
        return CLIENT;
    }

    /**
     * 发布通道消息
     *
     * @param channelKey 通道key
     * @param msg        发送数据
     * @param consumer   自定义处理
     */
    public static <T> void publish(String channelKey, T msg, Consumer<T> consumer) {
        RTopic topic = CLIENT.getTopic(channelKey);
        topic.publish(msg);
        consumer.accept(msg);
    }

    public static <T> void publish(String channelKey, T msg) {
        RTopic topic = CLIENT.getTopic(channelKey);
        topic.publish(msg);
    }

    /**
     * 订阅通道接收消息
     *
     * @param channelKey 通道key
     * @param clazz      消息类型
     * @param consumer   自定义处理
     */
    public static <T> void subscribe(String channelKey, Class<T> clazz, Consumer<T> consumer) {
        RTopic topic = CLIENT.getTopic(channelKey);
        topic.addListener(clazz, (channel, msg) -> consumer.accept(msg));
    }

    /**
     * 缓存基本的对象，Integer、String、实体类等
     *
     * @param key   缓存的键值
     * @param value 缓存的值
     */
    public static <T> void setCacheObject(final String key, final T value) {
        setCacheObject(key, value, false);
    }

    /**
     * 缓存基本的对象，保留当前对象 TTL 有效期
     *
     * @param key       缓存的键值
     * @param value     缓存的值
     * @param isSaveTtl 是否保留TTL有效期(例如: set之前ttl剩余90 set之后还是为90)
     * @since Redis 6.X 以上使用 setAndKeepTTL 兼容 5.X 方案
     */
    public static <T> void setCacheObject(final String key, final T value, final boolean isSaveTtl) {
        RBucket<Object> bucket = CLIENT.getBucket(key);
        if (isSaveTtl) {
            try {
                bucket.setAndKeepTTL(value);
            } catch (Exception e) {
                long timeToLive = bucket.remainTimeToLive();
                bucket.set(value);
                bucket.expire(Duration.ofMillis(timeToLive));
            }
        } else {
            bucket.set(value);
        }
    }

    /**
     * 缓存基本的对象，Integer、String、实体类等
     *
     * @param key      缓存的键值
     * @param value    缓存的值
     * @param duration 时间
     */
    public static <T> void setCacheObject(final String key, final T value, final Duration duration) {
        RBucket<T> result = CLIENT.getBucket(key);
        result.set(value);
        result.expire(duration);
    }

    /**
     * 注册对象监听器
     * <p>
     * key 监听器需开启 `notify-keyspace-events` 等 redis 相关配置
     *
     * @param key      缓存的键值
     * @param listener 监听器配置
     */
    public static <T> void addObjectListener(final String key, final ObjectListener listener) {
        RBucket<T> result = CLIENT.getBucket(key);
        result.addListener(listener);
    }

    /**
     * 设置有效时间
     *
     * @param key     Redis键
     * @param timeout 超时时间
     * @return true=设置成功；false=设置失败
     */
    public static boolean expire(final String key, final long timeout) {
        return expire(key, Duration.ofSeconds(timeout));
    }

    /**
     * 设置有效时间
     *
     * @param key      Redis键
     * @param duration 超时时间
     * @return true=设置成功；false=设置失败
     */
    public static boolean expire(final String key, final Duration duration) {
        RBucket rBucket = CLIENT.getBucket(key);
        return rBucket.expire(duration);
    }

    /**
     * 获得缓存的基本对象。
     *
     * @param key 缓存键值
     * @return 缓存键值对应的数据
     */
    public static <T> T getCacheObject(final String key) {
        RBucket<T> rBucket = CLIENT.getBucket(key);
        return rBucket.get();
    }

    /**
     * 获得key剩余存活时间
     *
     * @param key 缓存键值
     * @return 剩余存活时间
     */
    public static <T> long getTimeToLive(final String key) {
        RBucket<T> rBucket = CLIENT.getBucket(key);
        return rBucket.remainTimeToLive();
    }

    /**
     * 删除单个对象
     *
     * @param key 缓存的键值
     */
    public static boolean deleteObject(final String key) {
        return CLIENT.getBucket(key).delete();
    }

    /**
     * 删除集合对象
     *
     * @param collection 多个对象
     */
    public static void deleteObject(final Collection collection) {
        RBatch batch = CLIENT.createBatch();
        collection.forEach(t -> {
            batch.getBucket(t.toString()).deleteAsync();
        });
        batch.execute();
    }

    /**
     * 缓存List数据
     *
     * @param key      缓存的键值
     * @param dataList 待缓存的List数据
     * @return 缓存的对象
     */
    public static <T> boolean setCacheList(final String key, final List<T> dataList) {
        RList<T> rList = CLIENT.getList(key);
        return rList.addAll(dataList);
    }

    /**
     * 缓存List数据
     *
     * @param key      缓存的键值
     * @param dataList 待缓存的List数据
     * @return 缓存的对象
     */
    public static <T> boolean setNewCacheList(final String key, final List<T> dataList) {
        RList<T> rList = CLIENT.getList(key);
        rList.clear();
        return rList.addAll(dataList);
    }

    /**
     * 注册List监听器
     * <p>
     * key 监听器需开启 `notify-keyspace-events` 等 redis 相关配置
     *
     * @param key      缓存的键值
     * @param listener 监听器配置
     */
    public static <T> void addListListener(final String key, final ObjectListener listener) {
        RList<T> rList = CLIENT.getList(key);
        rList.addListener(listener);
    }

    /**
     * 获得缓存的list对象
     *
     * @param key 缓存的键值
     * @return 缓存键值对应的数据
     */
    public static <T> List<T> getCacheList(final String key) {
        RList<T> rList = CLIENT.getList(key);
        return rList.readAll();
    }

    /**
     * 缓存Set
     *
     * @param key     缓存键值
     * @param dataSet 缓存的数据
     * @return 缓存数据的对象
     */
    public static <T> boolean setCacheSet(final String key, final Set<T> dataSet) {
        RSet<T> rSet = CLIENT.getSet(key);
        return rSet.addAll(dataSet);
    }


    public static <T> boolean retainCacheSet(final String key, final Set<T> dataSet) {
        RSet<T> rSet = CLIENT.getSet(key);
        return rSet.retainAll(dataSet);
    }

    /**
     * 注册Set监听器
     * <p>
     * key 监听器需开启 `notify-keyspace-events` 等 redis 相关配置
     *
     * @param key      缓存的键值
     * @param listener 监听器配置
     */
    public static <T> void addSetListener(final String key, final ObjectListener listener) {
        RSet<T> rSet = CLIENT.getSet(key);
        rSet.addListener(listener);
    }

    /**
     * 获得缓存的set
     *
     * @param key 缓存的key
     * @return set对象
     */
    public static <T> Set<T> getCacheSet(final String key) {
        RSet<T> rSet = CLIENT.getSet(key);
        return rSet.readAll();
    }

    /**
     * 缓存Map
     *
     * @param key     缓存的键值
     * @param dataMap 缓存的数据
     */
    public static <T> void setCacheMap(final String key, final Map<String, T> dataMap) {
        if (dataMap != null) {
            RMap<String, T> rMap = CLIENT.getMap(key);
            rMap.putAll(dataMap);
        }
    }

    /**
     * 注册Map监听器
     * <p>
     * key 监听器需开启 `notify-keyspace-events` 等 redis 相关配置
     *
     * @param key      缓存的键值
     * @param listener 监听器配置
     */
    public static <T> void addMapListener(final String key, final ObjectListener listener) {
        RMap<String, T> rMap = CLIENT.getMap(key);
        rMap.addListener(listener);
    }


    //------------------------RMapCache操作----------------------

    /**
     * 获得缓存的Map
     *
     * @param key 缓存的键值
     * @return map对象
     */
    public static <T> Map<String, T> getRMapCache(final String key) {
        RMapCache<String, T> mapCache = CLIENT.getMapCache(key);
        return mapCache.getAll(mapCache.keySet());
    }

    /**
     * 往Hash中存入数据
     *
     * @param key   Redis键
     * @param hKey  Hash键
     * @param value 值
     */
    public static <T> void setMapCacheValue(final String key, final String hKey, final T value) {
        RMapCache<String, T> rMap = CLIENT.getMapCache(key);
        rMap.put(hKey, value);
    }

    public static <T> void setMapCacheValueWithExpire(final String key, final String hKey, final T value,
                                                      long ttl, TimeUnit ttlUnit) {
        RMapCache<String, T> rMap = CLIENT.getMapCache(key);
        rMap.putIfAbsent(hKey, value, ttl, ttlUnit);
    }

    /**
     * 获取Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <T> T getMapCacheValue(final String key, final String hKey) {
        RMapCache<String, T> rMap = CLIENT.getMapCache(key);
        return rMap.get(hKey);
    }

    /**
     * 删除Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <T> T delMapCacheValue(final String key, final String hKey) {
        RMapCache<String, T> rMap = CLIENT.getMapCache(key);
        return rMap.remove(hKey);
    }

    /**
     * 获得排序集合
     *
     * @param key 关键字
     * @param <T> 对象
     * @return
     */
    public static <T> RScoredSortedSet<T> getScoredSortedSet(final String key) {
        return CLIENT.getScoredSortedSet(key);
    }

    /**
     * 递增数值
     *
     * @param key   关键字
     * @param hKey  对应对象
     * @param value 值
     * @param <T>
     * @return
     */
    public static <T> Double addScoredSortedSet(final String key, final T hKey, final Double value) {
        RScoredSortedSet<T> scoredSortedSet = CLIENT.getScoredSortedSet(key);
        return scoredSortedSet.addScore(hKey, value);
    }

    /**
     * 获取分数
     *
     * @param key  关键字
     * @param hKey key
     * @param <T>
     * @return 分数
     */
    public static <T> Double getScoredSortedSetValue(final String key, final T hKey) {
        RScoredSortedSet<T> scoredSortedSet = CLIENT.getScoredSortedSet(key);
        return scoredSortedSet.getScore(hKey);
    }

    /**
     * 返回值的排名，分数从高到低排
     *
     * @param key
     * @param hKey
     * @param <T>
     * @return
     */
    public static <T> Integer getScoredSortedSetRank(final String key, final T hKey) {
        RScoredSortedSet<T> scoredSortedSet = CLIENT.getScoredSortedSet(key);
        return scoredSortedSet.revRank(hKey);
    }

    /**
     * 删除排序set
     *
     * @param key 关键字
     * @param <T>
     * @return
     */
    public static <T> Boolean delScoredSortedSet(final String key) {
        RScoredSortedSet<T> scoredSortedSet = CLIENT.getScoredSortedSet(key);
        return scoredSortedSet.delete();
    }

    /**
     * 按照索引返回数值范围
     *
     * @param key        关键字
     * @param startIndex 开始索引
     * @param endIndex   结束索引
     * @param <T>
     * @return 值的集合
     */
    public static <T> Collection<T> getScoredSortedSetRange(final String key, int startIndex, int endIndex) {
        RScoredSortedSet<T> scoredSortedSet = CLIENT.getScoredSortedSet(key);
        return scoredSortedSet.valueRangeReversed(startIndex, endIndex);
    }


    /**
     * 获得缓存的Map
     *
     * @param key 缓存的键值
     * @return map对象
     */
    public static <T> Map<String, T> getCacheMap(final String key) {
        RMap<String, T> rMap = CLIENT.getMap(key);
        return rMap.getAll(rMap.keySet());
    }

    /**
     * 往Hash中存入数据
     *
     * @param key   Redis键
     * @param hKey  Hash键
     * @param value 值
     */
    public static <T> void setCacheMapValue(final String key, final String hKey, final T value) {
        RMap<String, T> rMap = CLIENT.getMap(key);
        rMap.put(hKey, value);
    }

    /**
     * 获取Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <T> T getCacheMapValue(final String key, final String hKey) {
        RMap<String, T> rMap = CLIENT.getMap(key);
        return rMap.get(hKey);
    }

    /**
     * 删除Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <T> T delCacheMapValue(final String key, final String hKey) {
        RMap<String, T> rMap = CLIENT.getMap(key);
        return rMap.remove(hKey);
    }

    //----------------------队列操作---------------------------

    /**
     * 往Hash中存入数据
     *
     * @param hKey  Hash键
     * @param value 值
     */
    public static <T> boolean offerCacheQueueValue(final String hKey, final T value) {
        RQueue<T> queue = CLIENT.getQueue(hKey);
        return queue.offer(value);
    }

    /**
     * 获取Hash中的数据
     *
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <T> T pollCacheQueueValue(final String hKey) {
        RQueue<T> queue = CLIENT.getQueue(hKey);
        return queue.poll();
    }

    /**
     * 删除Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <T> void clearCacheQueueValue(final String hKey) {
        RQueue<T> queue = CLIENT.getQueue(hKey);
        queue.clear();
    }
    //-----------------------队列结束----------------------------------

    /**
     * 获取多个Hash中的数据
     *
     * @param key   Redis键
     * @param hKeys Hash键集合
     * @return Hash对象集合
     */
    public static <K, V> Map<K, V> getMultiCacheMapValue(final String key, final Set<K> hKeys) {
        RMap<K, V> rMap = CLIENT.getMap(key);
        return rMap.getAll(hKeys);
    }


    /**
     * <p>
     * 获得缓存的Map
     * LocalCachedMapOptions options = LocalCachedMapOptions.defaults()
     * 用于淘汰清除本地缓存内的元素
     * 共有以下几种选择:
     * LFU - 统计元素的使用频率，淘汰用得最少（最不常用）的。
     * LRU - 按元素使用时间排序比较，淘汰最早（最久远）的。
     * SOFT - 元素用Java的WeakReference来保存，缓存元素通过GC过程清除。
     * WEAK - 元素用Java的SoftReference来保存, 缓存元素通过GC过程清除。
     * NONE - 永不淘汰清除缓存元素。
     * .evictionPolicy(EvictionPolicy.NONE)
     * 如果缓存容量值为0表示不限制本地缓存容量大小
     * .cacheSize(1000)
     * 以下选项适用于断线原因造成了未收到本地缓存更新消息的情况。
     * 断线重连的策略有以下几种：
     * CLEAR - 如果断线一段时间以后则在重新建立连接以后清空本地缓存
     * LOAD - 在服务端保存一份10分钟的作废日志
     * 如果10分钟内重新建立连接，则按照作废日志内的记录清空本地缓存的元素
     * 如果断线时间超过了这个时间，则将清空本地缓存中所有的内容
     * NONE - 默认值。断线重连时不做处理。
     * .reconnectionStrategy(ReconnectionStrategy.NONE)
     * 以下选项适用于不同本地缓存之间相互保持同步的情况
     * 缓存同步策略有以下几种：
     * INVALIDATE - 默认值。当本地缓存映射的某条元素发生变动时，同时驱逐所有相同本地缓存映射内的该元素
     * UPDATE - 当本地缓存映射的某条元素发生变动时，同时更新所有相同本地缓存映射内的该元素
     * NONE - 不做任何同步处理
     * .syncStrategy(SyncStrategy.INVALIDATE)
     * 每个Map本地缓存里元素的有效时间，默认毫秒为单位
     * .timeToLive(10000)
     * 或者
     * .timeToLive(10, TimeUnit.SECONDS)
     * 每个Map本地缓存里元素的最长闲置时间，默认毫秒为单位
     * .maxIdle(10000)
     * 或者
     * .maxIdle(10, TimeUnit.SECONDS);
     * </p>
     * <code>
     * new LocalCachedMapOptions()
     * .cacheSize(0).timeToLive(0).maxIdle(0)
     * .evictionPolicy(EvictionPolicy.NONE)
     * .reconnectionStrategy(ReconnectionStrategy.NONE)
     * .cacheProvider(CacheProvider.REDISSON)
     * .syncStrategy(SyncStrategy.INVALIDATE)
     * .storeCacheMiss(false);
     * </code>
     */
    public static <K, V> RLocalCachedMap<K, V> getLocalCachedMapInstance(final String key) {
        return CLIENT.getLocalCachedMap(key, LocalCachedMapOptions.defaults());
    }


    public static <K, V> RLocalCachedMap<K, V> getLocalCachedMapInstance(final String key,
                                                                         LocalCachedMapOptions localCachedMapOptions) {
        return CLIENT.getLocalCachedMap(key, localCachedMapOptions);
    }

    /**
     * @param key
     * @param <K>
     * @param <V>
     * @return
     */
    public static <K, V> Map<K, V> getLocalCachedMap(final String key) {
        RLocalCachedMap<K, V> rMap = getLocalCachedMapInstance(key);
        return rMap.getAll(rMap.keySet());
    }


    /**
     * 往Hash中存入数据
     *
     * @param key
     * @param hKey
     * @param value
     * @param <K>
     * @param <V>
     */
    public static <K, V> void setLocalCachedMapValue(final String key, final K hKey, final V value) {
        RLocalCachedMap<K, V> rMap = getLocalCachedMapInstance(key);
        rMap.put(hKey, value);
    }

    /**
     * 往Hash中存入数据
     *
     * @param key                   Redis键
     * @param hKey                  Hash键
     * @param value                 值
     * @param localCachedMapOptions 缓存设置
     */
    public static <K, V> void setLocalCachedMapValue(final String key, final K hKey, final V value,
                                                     LocalCachedMapOptions localCachedMapOptions) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, localCachedMapOptions);
        rMap.put(hKey, value);
    }

    /**
     * 获取Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <K, V> V getLocalCachedMapValue(final String key, final K hKey) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, LocalCachedMapOptions.defaults());
        return rMap.get(hKey);
    }

    /**
     * 获取Hash中的数据
     *
     * @param key                   Redis键
     * @param hKey                  Hash键
     * @param localCachedMapOptions 缓存设置
     * @return Hash中的对象
     */
    public static <K, V> V getLocalCachedMapValue(final String key, final K hKey, LocalCachedMapOptions localCachedMapOptions) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, localCachedMapOptions);
        return rMap.get(hKey);
    }


    public static <K, V> RLocalCachedMap<K, V> getLocalCachedMap(final String key, LocalCachedMapOptions localCachedMapOptions) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, localCachedMapOptions);
        return rMap;
    }

    /**
     * 删除Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    public static <K, V> V delLocalCachedMapValue(final String key, final K hKey) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, LocalCachedMapOptions.defaults());
        return rMap.remove(hKey);
    }

    /**
     * 清空当前map的所有数据
     *
     * @param key
     * @param <K>
     * @param <V>
     */
    public static <K, V> void clearLocalCachedMap(final String key) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, LocalCachedMapOptions.defaults());
        rMap.clearLocalCache();
    }


    /**
     * 删除Hash中的数据
     *
     * @param key                   Redis键
     * @param hKey                  Hash键
     * @param localCachedMapOptions 缓存设置
     * @return Hash中的对象
     */
    public static <K, V> V delLocalCachedMapValue(final String key, final K hKey, LocalCachedMapOptions localCachedMapOptions) {
        RLocalCachedMap<K, V> rMap = CLIENT.getLocalCachedMap(key, localCachedMapOptions);
        return rMap.remove(hKey);
    }

    /**
     * 获取多个Hash中的数据
     *
     * @param key   Redis键
     * @param hKeys Hash键集合
     * @return Hash对象集合
     */
    public static <K, V> Map<K, V> getMultiLocalCachedMapValue(final String key, final Set<K> hKeys) {
        RLocalCachedMap<K, V> localCachedMap = CLIENT.getLocalCachedMap(key, LocalCachedMapOptions.defaults());
        return localCachedMap.getAll(hKeys);
    }


    /**
     * 获得缓存的基本对象列表
     *
     * @param pattern 字符串前缀
     * @return 对象列表
     */
    public static Collection<String> keys(final String pattern) {
        Iterable<String> iterable = CLIENT.getKeys().getKeysByPattern(pattern);
        return IterUtil.toList(iterable);
    }

    /**
     * 检查redis中是否存在key
     *
     * @param key 键
     */
    public static Boolean hasKey(String key) {
        RKeys rKeys = CLIENT.getKeys();
        return rKeys.countExists(key) > 0;
    }

    /**
     * key值自增
     *
     * @param key 键
     * @return
     */
    public static Long incrementAndGet(String key) {
        RAtomicLong atomicLong = CLIENT.getAtomicLong(key);
        return atomicLong.incrementAndGet();
    }

}
