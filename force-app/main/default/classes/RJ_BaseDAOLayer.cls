public abstract class RJ_BaseDAOLayer {
    protected abstract String getSObjectName();
    protected List<SObject> executeQuery(String soql, String cacheSuffix, Boolean useCache){
        String key = getSObjectName()+'_'+cacheSuffix;
        if(useCache){
            List<SObject> cached = RJ_QueryCacheProvider.get(key);
            if(cached!=null){
                return cached;
            }
        }

        List<SObject> records =  database.query(soql);
        if(useCache){
            RJ_QueryCacheProvider.put(key, records);
        }
        return records;
    }

    public void invalidateCache(){
        RJ_QueryCacheProvider.invalidate(getSObjectName());
    }
}