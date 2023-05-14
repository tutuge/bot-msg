package com.ruoyi.common.utils.cache;


import com.github.benmanes.caffeine.cache.CacheLoader;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import com.github.benmanes.caffeine.cache.RemovalListener;
import lombok.extern.slf4j.Slf4j;

import java.time.Duration;
import java.util.concurrent.Executors;

/**
 * Cache 工具类
 *
 * @author 芋道源码
 */
@Slf4j
public class CacheUtils {

    public static <K, V> LoadingCache<K, V> buildAsyncReloadingCache(Duration duration, CacheLoader<K, V> loader) {
        return buildAsyncReloadingCacheWithConf(loader, 5, 200, duration,
                Duration.ofSeconds(120L), Duration.ofSeconds(120L));
    }

    public static <K, V> LoadingCache<K, V> buildAsyncReloadingCacheWithConf(CacheLoader<K, V> loader,
                                                                             Integer initialCapacity,
                                                                             Integer maximumSize,
                                                                             Duration refreshAfterWrite,
                                                                             Duration expireAfterWrite,
                                                                             Duration expireAfterAccess) {
        return Caffeine.newBuilder()
                // 初始的缓存空间大小
                .initialCapacity(initialCapacity)
                // 缓存的最大条数
                .maximumSize(maximumSize)
                // 只阻塞当前数据加载线程，其他线程返回旧值
                .refreshAfterWrite(refreshAfterWrite)
                .expireAfterWrite(expireAfterWrite)
                .expireAfterAccess(expireAfterAccess)
                .removalListener((RemovalListener<K, V>) (key, value, removalCause) ->
                        log.info("Key： {} ，值：{} was removed!原因 ({}) \n", key, value, removalCause))
                .executor(Executors.newCachedThreadPool())
                // 通过 asyncReloading 实现全异步加载，包括 refreshAfterWrite 被阻塞的加载线程
                .build(loader);
    }
}
