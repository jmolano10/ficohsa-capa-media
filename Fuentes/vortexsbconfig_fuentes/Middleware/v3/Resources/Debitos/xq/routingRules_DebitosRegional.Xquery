<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
<routing>
   <rule>
      <origin>HN01</origin>
      <serviceName>Middleware/v3/ProxyServices/Debitos/local/DebitosHN</serviceName>      
   </rule>
   <rule>
      <origin>GT01</origin>
      <serviceName>Middleware/v3/ProxyServices/Debitos/local/DebitosGT</serviceName>      
   </rule>
   <rule>
      <origin>NI01</origin>
      <serviceName>Middleware/v3/ProxyServices/Debitos/local/DebitosNI</serviceName>      
   </rule>
   <rule>
      <origin>PA01</origin>
      <serviceName>Middleware/v3/ProxyServices/Debitos/local/DebitosPA</serviceName>      
   </rule>
</routing>]]></con:xquery>
</con:xqueryEntry>