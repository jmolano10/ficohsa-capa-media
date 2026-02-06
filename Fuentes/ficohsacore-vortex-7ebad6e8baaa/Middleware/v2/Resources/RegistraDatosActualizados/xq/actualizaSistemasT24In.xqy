xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:actualizaSistemasT24" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosActualizados/xq/actualizaSistemasT24In/";

declare function xf:actualizaSistemasT24In($request as xs:string, $processType as xs:string, $operationType as xs:string, $uuid as xs:string)
    as element(ns0:actualizaSistemasT24) {
        <ns0:actualizaSistemasT24>
            <PROCESS_TYPE>{ $processType }</PROCESS_TYPE>
            <OPERATION_TYPE>{ $operationType }</OPERATION_TYPE>
            <CUSTOMER_DATA>
             {
                      let $response := <DATA>{ fn-bea:inlinedXML($request) }</DATA>
                      let  $responseXml := $response/CUSTOMER_DATA
                      return(
                   <CUSTOMER_INFO>
                  {
                       let $customerInfo := $responseXml/CUSTOMER_INFO
                       return
                       (
                            <UUID>{ $uuid }</UUID>,
                            <CUSTOMER_ID>{ string($customerInfo/CUSTOMER_ID/text()) }</CUSTOMER_ID>,
                            if (string($customerInfo/NATIONALITY/text()) != '')then (
                            <NATIONALITY>{ string($customerInfo/NATIONALITY/text()) }</NATIONALITY>
                            )else(),
                             if (string($customerInfo/MARITAL_STATUS/text()) != '')then (
                            <MARITAL_STATUS>{ string($customerInfo/MARITAL_STATUS/text()) }</MARITAL_STATUS>
                            )else(),
                             if (string($customerInfo/SPOUSE_NAME/text()) != '')then (
                            <SPOUSE_NAME>{  string($customerInfo/SPOUSE_NAME/text()) }</SPOUSE_NAME>
                            )else(),
                            if (string($customerInfo/CUSTOMER_SINCE/text()) != '')then (
                            <CUSTOMER_SINCE>{ string($customerInfo/CUSTOMER_SINCE/text())  }</CUSTOMER_SINCE>
                            )else(),
                             if (string($customerInfo/PROFESSION/text()) != '')then (
                            <PROFESSION>{ string($customerInfo/PROFESSION/text()) }</PROFESSION>
                            )else(),
                             if (string($customerInfo/JOB_TITLE/text()) != '')then (
                            <JOB_TITLE>{ string($customerInfo/JOB_TITLE/text()) }</JOB_TITLE>
                            )else(),
                            if (string($customerInfo/LINE_OF_BUSINESS/text()) != '')then (
                            <LINE_OF_BUSINESS>{ string($customerInfo/LINE_OF_BUSINESS/text()) }</LINE_OF_BUSINESS>
                              )else(),
                              if (string($customerInfo/INCOME_RANGES/text()) != '')then (
                            <INCOME_RANGES>{ string($customerInfo/INCOME_RANGES/text()) }</INCOME_RANGES>
                              )else(),
                              if (string($customerInfo/CELLULAR/text()) != '')then (
                            <CELLULAR>{ string($customerInfo/CELLULAR/text()) }</CELLULAR>
                            )else()
                    )
                    }
                </CUSTOMER_INFO>,
                <IDENTIFICATION_INFO>
                 {
                      let $identificationInfo := $responseXml/IDENTIFICATION_INFO
                      return
                      (
                            if (string($identificationInfo/LEGAL_DOCUMENT_NAME/text()) != '')then (
                           <LEGAL_DOCUMENT_NAME>{ string($identificationInfo/LEGAL_DOCUMENT_NAME/text()) }</LEGAL_DOCUMENT_NAME>
                            )else(),
                            if (string($identificationInfo/LEGAL_ID/text()) != '')then (
                           <LEGAL_ID>{ string($identificationInfo/LEGAL_ID/text()) }</LEGAL_ID>
                            )else(),
                            if (string($identificationInfo/ALTERNATE_DOCUMENT_NAME/text()) != '')then (
                           <ALTERNATE_DOCUMENT_NAME>{ string($identificationInfo/ALTERNATE_DOCUMENT_NAME/text()) }</ALTERNATE_DOCUMENT_NAME>
                            )else(),
                            if (string($identificationInfo/ALTERNATE_ID/text()) != '')then (
                           <ALTERNATE_ID>{ string($identificationInfo/ALTERNATE_ID/text()) }</ALTERNATE_ID>
                           )else()
                    )
                 }
                </IDENTIFICATION_INFO>,
                 for $addressInfo  in $responseXml/ADDRESS_INFO
                 return
                <ADDRESS_INFO>
                {
                          if (string($addressInfo/TYPE/text()) != '')then (
                          <TYPE>{ string($addressInfo/TYPE/text()) }</TYPE>
                           )else(),
                            if (string($addressInfo/COUNTRY_CODE/text()) != '')then (
                          <COUNTRY_CODE>{ string($addressInfo/COUNTRY_CODE/text()) }</COUNTRY_CODE>
                           )else(),
                           if (string($addressInfo/STATE_CODE/text()) != '')then (
                          <STATE_CODE>{ string($addressInfo/STATE_CODE/text()) }</STATE_CODE>
                           )else(),
                           if (string($addressInfo/CITY_CODE/text()) != '')then (
                          <CITY_CODE>{ string($addressInfo/CITY_CODE/text()) }</CITY_CODE>
                           )else(),
                           if (string($addressInfo/COLONY_CODE/text()) != '')then (
                          <COLONY_CODE>{ string($addressInfo/COLONY_CODE/text()) }</COLONY_CODE>
                            )else(),
                            if (string($addressInfo/HOUSE_NUMBER/text()) != '')then (
                          <HOUSE_NUMBER>{ string($addressInfo/HOUSE_NUMBER/text()) }</HOUSE_NUMBER>
                            )else(),
                             if (string($addressInfo/REFERENCES/text()) != '')then (
                          <REFERENCES>{ string($addressInfo/REFERENCES/text()) }</REFERENCES>
                            )else(),
                             if (string($addressInfo/STREET/text()) != '')then (
                          <STREET>{ string($addressInfo/STREET/text()) }</STREET>
                            )else(),
                            if (string($addressInfo/AVENUE/text()) != '')then (
                          <AVENUE>{ string($addressInfo/AVENUE/text()) }</AVENUE>
                            )else(),
                             if (string($addressInfo/BLOCK/text()) != '')then (
                          <BLOCK>{ string($addressInfo/BLOCK/text()) }</BLOCK>
                             )else()
                    }
                </ADDRESS_INFO>,
                  for $phoneInfo  in $responseXml/PHONE_INFO
                  return
                <PHONE_INFO>
                {           
                            if (string($phoneInfo/TYPE/text()) != '')then (
                           <TYPE>{ string($phoneInfo/TYPE/text()) }</TYPE>
                             )else(),
                             if (string($phoneInfo/PHONE_NUMBER/text()) != '')then (
                           <PHONE_NUMBER>{ string($phoneInfo/PHONE_NUMBER/text()) }</PHONE_NUMBER>
                             )else(),
                             if (string($phoneInfo/EXTENSION/text()) != '')then (
                           <EXTENSION>{ string($phoneInfo/EXTENSION/text()) }</EXTENSION>
                            )else()
                }
                </PHONE_INFO>,
                  for $emailInfo  in $responseXml/EMAIL_INFO
                  return
                <EMAIL_INFO>
                {
                           if (string($emailInfo/TYPE/text()) != '')then (
                           <TYPE>{ string($emailInfo/TYPE/text()) }</TYPE>
                            )else(),
                            if (string($emailInfo/EMAIL/text()) != '')then (
                           <EMAIL>{ string($emailInfo/EMAIL/text()) }</EMAIL>
                           )else()
                 }          
                </EMAIL_INFO>,
                <CONTROL_INFO>
                 {
                      let $controlInfo := $responseXml/CONTROL_INFO
                      return
                      (
                             if (string($controlInfo/TICKET_NUMBER/text()) != '')then (
                           <TICKET_NUMBER>{ string($controlInfo/TICKET_NUMBER/text()) }</TICKET_NUMBER>
                             )else(),
                              if (string($controlInfo/CREATION_DATE/text()) != '')then (
                           <CREATION_DATE>{ string($controlInfo/CREATION_DATE/text()) }</CREATION_DATE>
                             )else(),
                             if (string($controlInfo/UPDATE_TIME/text()) != '')then (
                           <UPDATE_TIME>{ string($controlInfo/UPDATE_TIME/text()) }</UPDATE_TIME>
                             )else(),
                              if (string($controlInfo/LAST_UPDATE/text()) != '')then (
                           <LAST_UPDATE>{ string($controlInfo/LAST_UPDATE/text()) }</LAST_UPDATE>
                              )else(),
                               if (string($controlInfo/INTERFACE_USER/text()) != '')then (
                           <INTERFACE_USER>{ string($controlInfo/INTERFACE_USER/text()) }</INTERFACE_USER>
                              )else(),
                              if (string($controlInfo/BRANCH_CODE/text()) != '')then (
                           <BRANCH_CODE>{ string($controlInfo/BRANCH_CODE/text()) }</BRANCH_CODE>
                             )else(),
                             if (string($controlInfo/IP_ADDRESS/text()) != '')then (
                           <IP_ADDRESS>{ string($controlInfo/IP_ADDRESS/text()) }</IP_ADDRESS>
                             )else(),
                             if (string($controlInfo/WORK_UNIT_AREA/text()) != '')then (
                           <WORK_UNIT_AREA>{ string($controlInfo/WORK_UNIT_AREA/text()) }</WORK_UNIT_AREA>
                             )else(),
                              if (string($controlInfo/APPROVER_USER/text()) != '')then (
                           <APPROVER_USER>{ string($controlInfo/APPROVER_USER/text()) }</APPROVER_USER>
                           )else()
                          )
                      }
                </CONTROL_INFO>,
                <SYSTEM_INFO>
                {
                      let $systemInfo := $responseXml/SYSTEM_INFO
                      return
                      (
                            if (string($systemInfo/SOURCE/text()) != '')then (
                          <SOURCE>{ string($systemInfo/SOURCE/text()) }</SOURCE>
                            )else(),
                             if (string($systemInfo/STATUS/text()) != '')then (
                          <STATUS>{ string($systemInfo/STATUS/text()) }</STATUS>
                            )else(),
                            if (string($systemInfo/COUNTRY/text()) != '')then (
                          <COUNTRY>{ string($systemInfo/COUNTRY/text()) }</COUNTRY>
                            )else()
                          )
                      }
                </SYSTEM_INFO>
                )
             }
            </CUSTOMER_DATA>  
        </ns0:actualizaSistemasT24>
};

declare variable $request as xs:string external;
declare variable $processType as xs:string external;
declare variable $operationType as xs:string external;
declare variable $uuid as xs:string external;

xf:actualizaSistemasT24In($request, $processType, $operationType, $uuid)