import 'package:splitwise/stores/mapping_store.dart';

String EUID(String email)
{
  if(MappingStore.mapping[email] == null)
    {
      return "NOTFOUND";
    }
  return MappingStore.mapping[email]!;
}

String UIDE(String uid)
{
  for(String email in MappingStore.mapping.keys)
    {
      if(MappingStore.mapping[email] == uid)
        {
          return email;
        }
    }
  return "NOT FOUND";
}

String UIDN(String uid)
{
  return MappingStore.mapping[uid]!;
}

String NUID(String name)
{
  for(String uid in MappingStore.mapping.keys)
  {
    if(MappingStore.mapping[uid] == name)
    {
      return uid;
    }
  }
  return "NOT FOUND";
}



