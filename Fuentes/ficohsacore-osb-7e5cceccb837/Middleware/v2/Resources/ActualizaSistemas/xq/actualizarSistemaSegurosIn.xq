(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns1:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaSistemas" location="../../../BusinessServices/ACSELX/ActualizarSistema/wsdl/WsDataBanco.asmx.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizarSistemaSegurosIn/";

declare function xf:actualizarSistemaSegurosIn($actualizaSistemas1 as element(ns1:actualizaSistemas))
    as element(ns0:actualizaSistemas) {
        <ns0:actualizaSistemas>
            <ns0:PROCESS_TYPE>{ data($actualizaSistemas1/PROCESS_TYPE) }</ns0:PROCESS_TYPE>
            <ns0:OPERATION_TYPE>{ data($actualizaSistemas1/OPERATION_TYPE) }</ns0:OPERATION_TYPE>
            <ns0:CUSTOMER_DATA>
              {
                   for $customerData in $actualizaSistemas1/CUSTOMER_DATA
                   return(
                <ns0:CUSTOMERS_DATA>
                    <ns0:CUSTOMER_INFO>
                        <ns0:INFO>
                        {
                           for $customerInfo in $customerData/CUSTOMER_INFO/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($customerInfo/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($customerInfo/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:CUSTOMER_INFO>
                    <ns0:IDENTIFICATION_INFO>
                        <ns0:INFO>
                        {
                           for $identificationInfo in $customerData/IDENTIFICATION_INFO/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($identificationInfo/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($identificationInfo/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:IDENTIFICATION_INFO>
                    {
                    if(empty($customerData/ADDRESS_INFO)) then (
                      <ns0:ADDRESS_INFO>
                        <ns0:INFO>
                        </ns0:INFO>
                    </ns0:ADDRESS_INFO>
                     )else(
                      for $addressInfo in $customerData/ADDRESS_INFO
                    return
                    (
                     <ns0:ADDRESS_INFO>
                        <ns0:INFO>
                        {
                           for $address in $addressInfo/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($address/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($address/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:ADDRESS_INFO>
                    )              
                    )
                    }
                    {
                    if(empty($customerData/PHONE_INFO)) then (
                      <ns0:PHONE_INFO>
                        <ns0:INFO>
                        </ns0:INFO>
                    </ns0:PHONE_INFO>
                     )else(
                       for $phoneInfo in $customerData/PHONE_INFO
                    return
                    (
                    <ns0:PHONE_INFO>
                        <ns0:INFO>
                        {
                           for $phone in $phoneInfo/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($phone/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($phone/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:PHONE_INFO>
                    )              
                    )
                    }
                    {
                    if(empty($customerData/EMAIL_INFO)) then (
                      <ns0:EMAIL_INFO>
                        <ns0:INFO>
                        </ns0:INFO>
                    </ns0:EMAIL_INFO>
                     )else(
                    for $emailInfo in $customerData/EMAIL_INFO
                    return
                    (
                    <ns0:EMAIL_INFO>
                        <ns0:INFO>
                        {
                           for $email in $emailInfo/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($email/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($email/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:EMAIL_INFO>
                    )            
                    )
                    }
                    <ns0:CONTROL_INFO>
                        <ns0:INFO>
                        {
                           for $controlInfo in $customerData/CONTROL_INFO/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($controlInfo/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($controlInfo/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:CONTROL_INFO>
                    <ns0:SYSTEM_INFO>
                        <ns0:INFO>
                        {
                           for $systemInfo in $customerData/SYSTEM_INFO/INFO
                           return
                            <ns0:INFO>
                                <ns0:NAME>{ data($systemInfo/NAME) }</ns0:NAME>
                                <ns0:VALUE>{ data($systemInfo/VALUE) }</ns0:VALUE>
                            </ns0:INFO>
                            }
                        </ns0:INFO>
                    </ns0:SYSTEM_INFO>
                </ns0:CUSTOMERS_DATA>
                )
                }
            </ns0:CUSTOMER_DATA>
        </ns0:actualizaSistemas>
};

declare variable $actualizaSistemas1 as element(ns1:actualizaSistemas) external;

xf:actualizarSistemaSegurosIn($actualizaSistemas1)