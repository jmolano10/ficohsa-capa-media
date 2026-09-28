(:: pragma bea:global-element-return element="ns0:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosActualizados/xq/actualizaSistemasIn/";

declare function xf:actualizaSistemasIn( $processType as xs:string, $operationType as xs:string, $request as xs:string, $targetSystem as xs:string, $uuid as xs:string)
    as element(ns0:actualizaSistemas) {
        <ns0:actualizaSistemas>
        <PROCESS_TYPE>{ $processType }</PROCESS_TYPE>
        <OPERATION_TYPE>{ $operationType }</OPERATION_TYPE>
               {
               let $response := <DATA>{ fn-bea:inlinedXML($request) }</DATA>
               for  $responseXml in $response/CUSTOMER_DATA
               return(
         <CUSTOMER_DATA>
                <CUSTOMER_INFO>
                <INFO>
                        <NAME>UUID</NAME>
                        <VALUE>{ $uuid }</VALUE>
                        <STATUS>KEPT</STATUS>
                    </INFO>
                {
                 for $customerInfo in $responseXml/CUSTOMER_INFO/INFO
                 return
                    <INFO>
                        <NAME>{ string($customerInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($customerInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($customerInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </CUSTOMER_INFO>
                <IDENTIFICATION_INFO>
                {
                 for $identificationInfo in $responseXml/IDENTIFICATION_INFO/INFO
                 return
                    <INFO>
                        <NAME>{ string($identificationInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($identificationInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($identificationInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </IDENTIFICATION_INFO>
                {
                for  $ADDRESS in $responseXml/ADDRESS_INFO
                return
                <ADDRESS_INFO>
                {
                 for $addressInfo in $ADDRESS/INFO
                 return
                    <INFO>
                        <NAME>{ string($addressInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($addressInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($addressInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </ADDRESS_INFO>
                }
                {
                for  $PHONE in $responseXml/PHONE_INFO
                return
                <PHONE_INFO>
                {
                 for $phoneInfo in $PHONE/INFO
                 return
                    <INFO>
                        <NAME>{ string($phoneInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($phoneInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($phoneInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </PHONE_INFO>
                }
                {
                 for $EMAIL in $responseXml/EMAIL_INFO
                 return
                <EMAIL_INFO>
                {
                 for $emailInfo in $EMAIL/INFO
                 return
                    <INFO>
                        <NAME>{ string($emailInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($emailInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($emailInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </EMAIL_INFO>
                }
                <CONTROL_INFO>
                {
                 for $controlInfo in $responseXml/CONTROL_INFO/INFO
                 return
                    <INFO>
                        <NAME>{ string($controlInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($controlInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($controlInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </CONTROL_INFO>
                <SYSTEM_INFO>
                 <INFO>
                        <NAME>TARGET_SYSTEM</NAME>
                        <VALUE>{ $targetSystem }</VALUE>
                        <STATUS>KEPT</STATUS>
                    </INFO>
                {
                 for $systemInfo in $responseXml/SYSTEM_INFO/INFO
                 return
                    <INFO>
                        <NAME>{ string($systemInfo/NAME/text()) }</NAME>
                        <VALUE>{ string($systemInfo/VALUE/text()) }</VALUE>
                        <STATUS>{ string($systemInfo/STATUS/text()) }</STATUS>
                    </INFO>
                    }
                </SYSTEM_INFO>
            </CUSTOMER_DATA>
            )
            }
        </ns0:actualizaSistemas>
};

declare variable $processType as xs:string external;
declare variable $operationType as xs:string external;
declare variable $request as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $uuid as xs:string external;

xf:actualizaSistemasIn($processType, $operationType, $request,$targetSystem,$uuid)