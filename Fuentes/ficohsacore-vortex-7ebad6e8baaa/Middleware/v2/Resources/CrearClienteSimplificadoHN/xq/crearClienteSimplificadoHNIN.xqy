xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaClienteSimplificadoIN" element="ns1:CreaClienteSimplificado" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreaciondeClienteSimplificado" location="../../../BusinessServices/T24/CrearClienteSimplificado/xsd/XMLSchema_1252959786.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CrearClienteSimplificadoHN/xq/crearClienteSimplificadoHNIN/";

(: Se encarga de retornar el wsa:Action correspondiente a la operación que se desea invocar :)
declare function getGender($type as xs:string) as xs:string {
	if ($type = "MALE") then
	  "01"
   else if ($type = "FEMALE") then
	  "02"
	else 
		"Invalid Operation"
};
(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };	


declare function xf:crearClienteSimplificadoHNIN($creaClienteSimplificadoIN as element(ns1:CreaClienteSimplificado),$requestHeaderIN as element(ns2:RequestHeader))
    as element(ns0:CreaciondeClienteSimplificado) {
        <ns0:CreaciondeClienteSimplificado>
          <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)), 
												data($requestHeaderIN/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                								data($requestHeaderIN/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            {
             if (data($creaClienteSimplificadoIN/CUSTOMER_ID)!='')then(
              <CUSTOMERINDIVIDUALSIMPLIOPENWSType id= "{ data($creaClienteSimplificadoIN/CUSTOMER_ID) }">
              <ACCOUNTOFFICER>{ data($creaClienteSimplificadoIN/ACCOUNT_OFFICER) }</ACCOUNTOFFICER>
                <gOTHEROFFICER>
                    <OTHEROFFICER>{ data($creaClienteSimplificadoIN/BRANCH_CODE) }</OTHEROFFICER>
                </gOTHEROFFICER>
                <gLEGALID>
                    <mLEGALID>
                        <LEGALID>{ data($creaClienteSimplificadoIN/LEGAL_ID) }</LEGALID>
                        <LEGALISSDATE>{ data($creaClienteSimplificadoIN/LEGAL_ISSUED_DATE) }</LEGALISSDATE>
                    </mLEGALID>
                </gLEGALID>
                <GIVENNAMES>{ concat(data($creaClienteSimplificadoIN/FIRST_NAME)," ",data($creaClienteSimplificadoIN/SECOND_NAME)) }</GIVENNAMES>
                <FAMILYNAME>{ concat(data($creaClienteSimplificadoIN/FIRST_LASTNAME)," ",data($creaClienteSimplificadoIN/SECOND_LASTNAME)) }</FAMILYNAME>
                <GENDER>{ getGender(data($creaClienteSimplificadoIN/GENDER)) }</GENDER>
                <DATEOFBIRTH>{ data($creaClienteSimplificadoIN/BIRTH_DATE) }</DATEOFBIRTH>
                <MARITALSTATUS>{ data($creaClienteSimplificadoIN/MARITAL_STATUS) }</MARITALSTATUS>
                {
                    let $PHONE_INFO := $creaClienteSimplificadoIN/PHONE_INFO
                    return
                        <gPHONE1>
                             {
                            for $PHONE_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                            return
                            if (data($PHONE_ITEM/PHONE_TYPE)='PHONE')then(
                              if (data($PHONE_ITEM/ZIP_CODE)!='') then(
                                     <PHONE1>{ concat(data($PHONE_ITEM/ZIP_CODE),data($PHONE_ITEM/PHONE_NUMBER)) }</PHONE1>
                               )else(
                                     <PHONE1>{ concat('504',data($PHONE_ITEM/PHONE_NUMBER)) }</PHONE1>
                                  )
                            )else()
                            }
                        </gPHONE1>
                }
                 {
                    let $PHONE_INFO := $creaClienteSimplificadoIN/PHONE_INFO
                    return
                        <gSMS1>
                             {
                            for $PHONE_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                            return
                            if (data($PHONE_ITEM/PHONE_TYPE)='SMS')then(
                             if (data($PHONE_ITEM/ZIP_CODE)!='') then(
                                     <SMS1>{ concat(data($PHONE_ITEM/ZIP_CODE),data($PHONE_ITEM/PHONE_NUMBER)) }</SMS1>
                               )else(
                                     <SMS1>{ concat('504',data($PHONE_ITEM/PHONE_NUMBER)) }</SMS1>
                                  )
                            )else()
                            }
                        </gSMS1>
                }
                {
                    let $EMAIL_ADDRESS_INFO := $creaClienteSimplificadoIN/EMAIL_ADDRESS_INFO
                    return
                        <gEMAIL1>
                         {
                            for $EMAIL_ADDRESS_ITEM in $EMAIL_ADDRESS_INFO/EMAIL_ITEM
                            return
                            <EMAIL1>{ data($EMAIL_ADDRESS_ITEM/EMAIL) }</EMAIL1>
                           }
                        </gEMAIL1>
                }
                <gEMPLOYMENTSTATUS>
                    <mEMPLOYMENTSTATUS>
                        {
                            for $JOB_DESCRIPTION in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/JOB_DESCRIPTION
                            return
                                <EMPLOYERSNAME>{ data($JOB_DESCRIPTION) }</EMPLOYERSNAME>
                        }
                    </mEMPLOYMENTSTATUS>
                </gEMPLOYMENTSTATUS>
                 {
                   
                        <CUSTOMERTYPE>ACTIVE</CUSTOMERTYPE>
                      
                }
                {
                    for $PROFESION_CODE in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/PROFESION_CODE
                    return
                        <PROFESIONTRADE>{ data($PROFESION_CODE) }</PROFESIONTRADE>
                }
                
                {
                    for $INCOME_SOURCE in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/INCOME_SOURCE
                    return
                        <SRCOFINCOME>{ data($INCOME_SOURCE) }</SRCOFINCOME>
                }
                {
                    let $ADDRESS_INFO := $creaClienteSimplificadoIN/ADDRESS_INFO
                    return
                        <gADDRESS.TYPE>
                            {
                                for $ADDRESS_ITEM in $ADDRESS_INFO/ADDRESS_ITEM
                                return
                                    <mADDRESS.TYPE>
                                        <ADDRESSTYPE>{ data($ADDRESS_ITEM/ADDRESS_TYPE) }</ADDRESSTYPE>
                                        <MAINADPHYCOR>{ data($ADDRESS_ITEM/IS_MAIN_ADDRESS) }</MAINADPHYCOR>
                                        <COUNTRYCODE>{ data($ADDRESS_ITEM/COUNTRY_CODE) }</COUNTRYCODE>
                                        <STATECODE>{ data($ADDRESS_ITEM/STATE_CODE) }</STATECODE>
                                        <CITYCODE>{ data($ADDRESS_ITEM/CITY_CODE) }</CITYCODE>
                                        {                                      
                                        if (data($ADDRESS_ITEM/COLONY_CODE)!='') then (
                                        <COLONYCODE>{ data($ADDRESS_ITEM/COLONY_CODE) }</COLONYCODE>)
                                        else(<COLONYCODE>HN.00.0000.000000</COLONYCODE>)
                                         }
                                        <NEIGHBPENDING>{ data($ADDRESS_ITEM/NEIGHBORHOOD) }</NEIGHBPENDING>
                                        <AVENUE>{ data($ADDRESS_ITEM/AVENUE) }</AVENUE>
                                        <ADDSTREET>{ data($ADDRESS_ITEM/STREET) }</ADDSTREET>
                                        <BLOCK>{ data($ADDRESS_ITEM/BLOCK) }</BLOCK>
                                        <HOUSENUMBER>{ data($ADDRESS_ITEM/HOUSE_NUMBER) }</HOUSENUMBER>
                                        <REFERENCES>{ data($ADDRESS_ITEM/REFERENCES) }</REFERENCES>
                                    </mADDRESS.TYPE>
                            }
                        </gADDRESS.TYPE>
                }
                <gINCOME.CCY>
                    <mINCOME.CCY>
                        {
                            for $PRINCIPAL_INCOME_AMOUNT in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/PRINCIPAL_INCOME_AMOUNT
                            return
                                <INCOMERANGES>{ data($PRINCIPAL_INCOME_AMOUNT) }</INCOMERANGES>
                        }
                    </mINCOME.CCY>
                 </gINCOME.CCY>
                    {
                    if (count(data($creaClienteSimplificadoIN/PHONE_INFO/PHONE_NUMBER_ITEM/PHONE_TYPE['PHONE']))>1)then(
                    <gEXTENSION>
                     { 
                    let $PHONE_INFO := $creaClienteSimplificadoIN/PHONE_INFO
                    return 
                     for $PHONE_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                         return 
                           if (data($PHONE_ITEM/PHONE_TYPE)='PHONE')then(
                          <mEXTENSION>                  
                            <TELEPHONEREFER> { data($PHONE_ITEM/PHONE_REFERENCE) }   </TELEPHONEREFER>    
                         </mEXTENSION>
                          )else()
                           
                         }
                    </gEXTENSION>
                     )else()
                     }
                     {
                    if (count(data($creaClienteSimplificadoIN/EMAIL_ADDRESS_INFO/EMAIL_ITEM))>1)then(
                    let $EMAIL_ADDRESS_INFO := $creaClienteSimplificadoIN/EMAIL_ADDRESS_INFO
                    return
                    <gLR.MAIN.AD.ELEC>
                      {
                      for $EMAIL_ADDRESS_ITEM in $EMAIL_ADDRESS_INFO/EMAIL_ITEM
                      return
                     <LRMAINADELEC> { data($EMAIL_ADDRESS_ITEM/IS_MAIN_ADDRESS) } </LRMAINADELEC>
                          }
                      </gLR.MAIN.AD.ELEC>   
                      )else()
                     }
               
                <LRWORK>{ data($creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/IS_WORK) }</LRWORK>
                <LRFSUMINGR>{ data($creaClienteSimplificadoIN/MONTHLY_TXN_VOLUME) }</LRFSUMINGR>
            </CUSTOMERINDIVIDUALSIMPLIOPENWSType>)
            else(
            <CUSTOMERINDIVIDUALSIMPLIOPENWSType>
             <ACCOUNTOFFICER>{ data($creaClienteSimplificadoIN/ACCOUNT_OFFICER) }</ACCOUNTOFFICER>
                <gOTHEROFFICER>
                    <OTHEROFFICER>{ data($creaClienteSimplificadoIN/BRANCH_CODE) }</OTHEROFFICER>
                </gOTHEROFFICER>
                <gLEGALID>
                    <mLEGALID>
                        <LEGALID>{ data($creaClienteSimplificadoIN/LEGAL_ID) }</LEGALID>
                        <LEGALISSDATE>{ data($creaClienteSimplificadoIN/LEGAL_ISSUED_DATE) }</LEGALISSDATE>
                    </mLEGALID>
                </gLEGALID>
                <GIVENNAMES>{ concat(data($creaClienteSimplificadoIN/FIRST_NAME)," ",data($creaClienteSimplificadoIN/SECOND_NAME)) }</GIVENNAMES>
                <FAMILYNAME>{ concat(data($creaClienteSimplificadoIN/FIRST_LASTNAME)," ",data($creaClienteSimplificadoIN/SECOND_LASTNAME)) }</FAMILYNAME>
                <GENDER>{ getGender(data($creaClienteSimplificadoIN/GENDER)) }</GENDER>
                <DATEOFBIRTH>{ data($creaClienteSimplificadoIN/BIRTH_DATE) }</DATEOFBIRTH>
                <MARITALSTATUS>{ data($creaClienteSimplificadoIN/MARITAL_STATUS) }</MARITALSTATUS>
                {
                    let $PHONE_INFO := $creaClienteSimplificadoIN/PHONE_INFO
                    return
                        <gPHONE1>
                             {
                            for $PHONE_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                            return
                            if (data($PHONE_ITEM/PHONE_TYPE)='PHONE')then(
                            <PHONE1>{ data($PHONE_ITEM/PHONE_NUMBER) }</PHONE1>
                            )else()
                            }
                        </gPHONE1>
                }
                 {
                    let $PHONE_INFO := $creaClienteSimplificadoIN/PHONE_INFO
                    return
                        <gSMS1>
                             {
                            for $PHONE_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                            return
                            if (data($PHONE_ITEM/PHONE_TYPE)='SMS')then(
                            <SMS1>{ data($PHONE_ITEM/PHONE_NUMBER) }</SMS1>
                            )else()
                            }
                        </gSMS1>
                }
                {
                    let $EMAIL_ADDRESS_INFO := $creaClienteSimplificadoIN/EMAIL_ADDRESS_INFO
                    return
                        <gEMAIL1>
                         {
                            for $EMAIL_ADDRESS_ITEM in $EMAIL_ADDRESS_INFO/EMAIL_ITEM
                            return
                            <EMAIL1>{ data($EMAIL_ADDRESS_ITEM/EMAIL) }</EMAIL1>
                           }
                        </gEMAIL1>
                }
                <gEMPLOYMENTSTATUS>
                    <mEMPLOYMENTSTATUS>
                        {
                            for $JOB_DESCRIPTION in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/JOB_DESCRIPTION
                            return
                                <EMPLOYERSNAME>{ data($JOB_DESCRIPTION) }</EMPLOYERSNAME>
                        }
                    </mEMPLOYMENTSTATUS>
                </gEMPLOYMENTSTATUS>
               
                {
                    for $PROFESION_CODE in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/PROFESION_CODE
                    return
                        <PROFESIONTRADE>{ data($PROFESION_CODE) }</PROFESIONTRADE>
                }
                
                {
                    for $INCOME_SOURCE in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/INCOME_SOURCE
                    return
                        <SRCOFINCOME>{ data($INCOME_SOURCE) }</SRCOFINCOME>
                }
                {
                    let $ADDRESS_INFO := $creaClienteSimplificadoIN/ADDRESS_INFO
                    return
                        <gADDRESS.TYPE>
                            {
                                for $ADDRESS_ITEM in $ADDRESS_INFO/ADDRESS_ITEM
                                return
                                    <mADDRESS.TYPE>
                                        <ADDRESSTYPE>{ data($ADDRESS_ITEM/ADDRESS_TYPE) }</ADDRESSTYPE>
                                        <MAINADPHYCOR>{ data($ADDRESS_ITEM/IS_MAIN_ADDRESS) }</MAINADPHYCOR>
                                        <COUNTRYCODE>{ data($ADDRESS_ITEM/COUNTRY_CODE) }</COUNTRYCODE>
                                        <STATECODE>{ data($ADDRESS_ITEM/STATE_CODE) }</STATECODE>
                                        <CITYCODE>{ data($ADDRESS_ITEM/CITY_CODE) }</CITYCODE>
                                        {                                      
                                        if (data($ADDRESS_ITEM/COLONY_CODE)!='') then (
                                        <COLONYCODE>{ data($ADDRESS_ITEM/COLONY_CODE) }</COLONYCODE>)
                                        else(<COLONYCODE>HN.00.0000.000000</COLONYCODE>)
                                         }
                                        <NEIGHBPENDING>{ data($ADDRESS_ITEM/NEIGHBORHOOD) }</NEIGHBPENDING>
                                        <AVENUE>{ data($ADDRESS_ITEM/AVENUE) }</AVENUE>
                                        <ADDSTREET>{ data($ADDRESS_ITEM/STREET) }</ADDSTREET>
                                        <BLOCK>{ data($ADDRESS_ITEM/BLOCK) }</BLOCK>
                                        <HOUSENUMBER>{ data($ADDRESS_ITEM/HOUSE_NUMBER) }</HOUSENUMBER>
                                        <REFERENCES>{ data($ADDRESS_ITEM/REFERENCES) }</REFERENCES>
                                    </mADDRESS.TYPE>
                            }
                        </gADDRESS.TYPE>
                }
                <gINCOME.CCY>
                    <mINCOME.CCY>
                        {
                            for $PRINCIPAL_INCOME_AMOUNT in $creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/PRINCIPAL_INCOME_AMOUNT
                            return
                                <INCOMERANGES>{ data($PRINCIPAL_INCOME_AMOUNT) }</INCOMERANGES>
                        }
                    </mINCOME.CCY>
                 </gINCOME.CCY>
                    {
                    if (count(data($creaClienteSimplificadoIN/PHONE_INFO/PHONE_NUMBER_ITEM/PHONE_TYPE['PHONE']))>1)then(
                    <gEXTENSION>
                     { 
                    let $PHONE_INFO := $creaClienteSimplificadoIN/PHONE_INFO
                    return 
                     for $PHONE_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                         return 
                           if (data($PHONE_ITEM/PHONE_TYPE)='PHONE')then(
                          <mEXTENSION>                  
                            <TELEPHONEREFER> { data($PHONE_ITEM/PHONE_REFERENCE) }   </TELEPHONEREFER>    
                         </mEXTENSION>
                          )else()
                           
                         }
                    </gEXTENSION>
                     )else()
                     }
                     {
                    if (count(data($creaClienteSimplificadoIN/EMAIL_ADDRESS_INFO/EMAIL_ITEM))>1)then(
                    let $EMAIL_ADDRESS_INFO := $creaClienteSimplificadoIN/EMAIL_ADDRESS_INFO
                    return
                    <gLR.MAIN.AD.ELEC>
                      {
                      for $EMAIL_ADDRESS_ITEM in $EMAIL_ADDRESS_INFO/EMAIL_ITEM
                      return
                     <LRMAINADELEC> { data($EMAIL_ADDRESS_ITEM/IS_MAIN_ADDRESS) } </LRMAINADELEC>
                          }
                      </gLR.MAIN.AD.ELEC>   
                      )else()
                     }
               
                <LRWORK>{ data($creaClienteSimplificadoIN/JOB_INFO/JOB_ITEM[1]/IS_WORK) }</LRWORK>
                <LRFSUMINGR>{ data($creaClienteSimplificadoIN/MONTHLY_TXN_VOLUME) }</LRFSUMINGR>
            </CUSTOMERINDIVIDUALSIMPLIOPENWSType>
            )
             }      
        </ns0:CreaciondeClienteSimplificado>
};

declare variable $creaClienteSimplificadoIN as element(ns1:CreaClienteSimplificado) external;
declare variable $requestHeaderIN as element(ns2:RequestHeader) external;

xf:crearClienteSimplificadoHNIN($creaClienteSimplificadoIN,$requestHeaderIN)