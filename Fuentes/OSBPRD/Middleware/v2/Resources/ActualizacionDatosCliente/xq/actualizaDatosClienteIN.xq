(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaDatosClienteIN" element="ns1:actualizaDatosCliente" location="../xsd/actualizacionDatosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ActualizaciondeDatosCliente" location="../../../BusinessServices/T24/actualizaDatosCliente/xsd/XMLSchema_1014999265.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/actualizaDatosClienteSBIN/";

			
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };


declare function xf:actualizaDatosClienteSBIN($requestHeaderIN as element(ns2:RequestHeader),
    $actualizaDatosClienteIN as element(ns1:actualizaDatosCliente))
    as element(ns0:ActualizaciondeDatosCliente) {
        <ns0:ActualizaciondeDatosCliente>
         <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)),
                        data($requestHeaderIN/Authentitacion/UserName))
                    }
                </userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                        data($requestHeaderIN/Authentication/Password))
                    }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <CUSTOMERINDIVIDUALACTDATOSWSType id = "{ data($actualizaDatosClienteIN/CUSTOMER_ID) }">
            {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='MARITAL_STATUS') then
                 if ($FIELD/VALUE!='') then (
                  <MARITALSTATUS>{ data($FIELD/VALUE) }</MARITALSTATUS>
                 )
                 else(
                  <MARITALSTATUS>NULL</MARITALSTATUS>
                )
              else() 
            }
            <gPHONE1>
            {
             for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
             let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM)   
             for $f  in (1 to $contador )
             let $contadorIndice:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD)    
             let $zipcode:=$actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[ID='ZIP_CODE']/VALUE
             for $g  in (1 to $contadorIndice )
             
                return
                    if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='PHONE_NUMBER' 
                         and $BLOCK/TYPE='PHONES' and $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/ID='PHONE') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                 
                                  <PHONE>{ concat($zipcode,data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE)) }</PHONE>
                                 )
                               else(
                                  <PHONE>{ concat('DELETE.',$actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/INDEX_ID) }</PHONE>
                                )
                             else()            
                  }
            </gPHONE1>
            <gSMS1>
            {
            for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
             let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM)   
             for $f in (1 to $contador )
             let $contadorIndice:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD)
                let $zipcode:=$actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[ID='ZIP_CODE']/VALUE
             for $g in (1 to $contadorIndice )
                return
                    if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='PHONE_NUMBER' 
                         and $BLOCK/TYPE='PHONES' and $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/ID='SMS') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <CELLPHONENUMBER>{concat($zipcode, data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE)) }</CELLPHONENUMBER>
                                 )
                               else(
                                  <CELLPHONENUMBER>{ concat('DELETE.',$actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/INDEX_ID) }</CELLPHONENUMBER>
                                )
                             else()
            }
            </gSMS1>
             {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='JOB_TITTLE') then
                 if ($FIELD/VALUE!='') then (
                  <JOBTITLE>{ data($FIELD/VALUE) }</JOBTITLE>
                 )
                 else(
                  <JOBTITLE>NULL</JOBTITLE>
                )
              else() 
            }
             {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='PROFESSION') then
                 if ($FIELD/VALUE!='') then (
                  <PROFESIONTRADE>{ data($FIELD/VALUE) }</PROFESIONTRADE>
                 )
                 else(
                  <PROFESIONTRADE>NULL</PROFESIONTRADE>
                )
              else() 
            }
            {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='SPOUSE_NAME') then
                 if ($FIELD/VALUE!='') then (
                  <SPOUSENAME>{ data($FIELD/VALUE) }</SPOUSENAME>
                 )
                 else(
                  <SPOUSENAME>NULL</SPOUSENAME>
                )
              else() 
            }
            <gADDRESS.TYPE>
            {
            for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
            let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM) 
            for $f in (1 to $contador )  
            let $contadorIndice:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD)
            let $DireccionCompleta:=''
            return
            if ($BLOCK/TYPE='ADDRESS' and $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/ID='ADDRESS_TYPE') then (
               <mADDRESS.TYPE>
                {  
                      
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/INDEX_ID!='') then (
                                  
                                  <ADDRESSTYPE>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/INDEX_ID) }</ADDRESSTYPE>
                                 )
                               else(
                                  <ADDRESSTYPE>NULL</ADDRESSTYPE>
                                )
                           
                  }
                 {
                  for $g in (1 to $contadorIndice )
                   
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='IS_MAIN_ADDRESS') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <MAINADPHYCOR>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</MAINADPHYCOR>
                                 )
                               else(
                                  <MAINADPHYCOR>NULL</MAINADPHYCOR>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='COUNTRY_CODE') then
                               
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <COUNTRYCODE>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</COUNTRYCODE>
                                 )
                               else(
                                  <COUNTRYCODE>NULL</COUNTRYCODE>
                                )
                          else()       
                 }
                 {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='STATE_CODE') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <STATECODE>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</STATECODE>
                                 )
                               else(
                                  <STATECODE>NULL</STATECODE>
                                )
                          else()       
                 }
                 {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='CITY_CODE' ) then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <CITYCODE>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</CITYCODE>
                                 )
                               else(
                                  <CITYCODE>NULL</CITYCODE>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='COLONY_CODE') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <COLONYCODE>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</COLONYCODE>
                                 )
                               else(
                                  <COLONYCODE>NULL</COLONYCODE>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return    
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='NEIGHBORHOOD') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <NEIGHBPENDING>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</NEIGHBPENDING
                                  >
                                 )
                               else(
                                  <NEIGHBPENDING>NULL</NEIGHBPENDING>
                                )
                          else()       
                 }
                 {
                  
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='AVENUE') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <AVENUE>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</AVENUE>
                                 )
                               else(
                                  <AVENUE>NULL</AVENUE>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='STREET') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <ADDSTREET>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</ADDSTREET>
                                 )
                               else(
                                  <ADDSTREET>NULL</ADDSTREET>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='BLOCK') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <BLOCK>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</BLOCK>
                                 )
                               else(
                                  <BLOCK>NULL</BLOCK>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='HOUSE_NUMBER' ) then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <HOUSENUMBER>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</HOUSENUMBER>
                                 )
                               else(
                                  <HOUSENUMBER>NULL</HOUSENUMBER>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='REFERENCES') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <REFERENCES>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</REFERENCES>
                                 )
                               else(
                                  <REFERENCES>NULL</REFERENCES>
                                )
                          else()       
                 }
                 {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='ADDRESS_LINE_1') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <COMPLETEADDRES>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</COMPLETEADDRES>
                                 )
                               else(
                                  <COMPLETEADDRES>NULL</COMPLETEADDRES>
                                )
                          else()       
                 }
                  {
                  for $g in (1 to $contadorIndice )
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='ADDRESS_LINE_2') then
                               if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <COMPLETEADDRES>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) }</COMPLETEADDRES>
                                 )
                               else(
                                  <COMPLETEADDRES>NULL</COMPLETEADDRES>
                                )
                          else()       
                 }
                 
                 
                
               </mADDRESS.TYPE>
             )
             else()
           
                   
            }
            </gADDRESS.TYPE>
            <gLR.NAC.MUL.VAL>
            {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='NATIONALITY') then
                 if ($FIELD/VALUE!='') then (
                  <LRNACMULVAL>{ data($FIELD/VALUE) }</LRNACMULVAL>
                 )
                 else(
                  <LRNACMULVAL>NULL</LRNACMULVAL>
                )
              else() 
            }
            </gLR.NAC.MUL.VAL>
            {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='TOTAL_INCOME') then
                 if ($FIELD/VALUE!='') then (
                  <LRFSUMINGR>{ data($FIELD/VALUE) }</LRFSUMINGR>
                 )
                 else(
                  <LRFSUMINGR>NULL</LRFSUMINGR>
                )
              else() 
            }
             {
             let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
             for $FIELD in $FIELDS/FIELD
             return
             if ($FIELD/ID='LINE_OF_BUSINESS') then
                 if ($FIELD/VALUE!='') then (
                  <LRGIRONEGOCIO>{ data($FIELD/VALUE) }</LRGIRONEGOCIO>
                 )
                 else(
                  <LRGIRONEGOCIO>NULL</LRGIRONEGOCIO>
                )
              else() 
            }
          </CUSTOMERINDIVIDUALACTDATOSWSType>
        </ns0:ActualizaciondeDatosCliente>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $actualizaDatosClienteIN as element(ns1:actualizaDatosCliente) external;

xf:actualizaDatosClienteSBIN($requestHeaderIN,
    $actualizaDatosClienteIN)