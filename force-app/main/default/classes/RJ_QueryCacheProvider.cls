public class RJ_QueryCacheProvider {
 private static Map<String,List<SObject>> cacheMap = new Map<String,List<SObject>>();
 
 public static List<SObject> get(String key){
    //return cacheMap.get(key);
    System.debug('===== RJ_QueryCacheProvider.get START =====');
        System.debug('Requested Key : ' + key);
        List<SObject> records = cacheMap.get(key);
        if(records != null){
            System.debug('Cache HIT. Records Found : ' + records.size());
        }else{
            System.debug('Cache MISS. No Records Found.');
        }
        System.debug('===== RJ_QueryCacheProvider.get END =====');
        return records;
 }
 public static void put(String key, List<SObject> records){
      System.debug('===== RJ_QueryCacheProvider.put START =====');
      System.debug('Saving Key : ' + key);
      System.debug('Records Count : ' + records.size());
      cacheMap.put(key, records);
      System.debug('Current Cache Keys : ' + cacheMap.keySet());
      System.debug('===== RJ_QueryCacheProvider.put END =====');
 }
 public static void invalidate(String prefix){
      System.debug('===== RJ_QueryCacheProvider.invalidate START =====');
      System.debug('Prefix Received : ' + prefix);

    for(String key:new List<String>(cacheMap.keySet())){
      System.debug('Checking Key : ' + key);
        if(key.startsWith(prefix)){
         System.debug('Removing Cache Key : ' + key);
            cacheMap.remove(key);
        }
    }
      System.debug('Remaining Keys After Remove : ' + cacheMap.keySet());
      System.debug('===== RJ_QueryCacheProvider.invalidate END =====');
 }
}