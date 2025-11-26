(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registraDatosActualizados" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosActualizados/xq/registraDatosActualizadosIn/";

        declare function obtenerInfo($dataNumber as xs:integer, $MESSAGE as xs:string, $number as xs:integer)
            as element(*){
               <INFO>
                   {
                      for $MESSAGE1 at $j in fn:tokenize(fn:tokenize(fn:tokenize($MESSAGE, '@PM')[$dataNumber], '@FM')[$number], '@VM')                                
                         let $trama := fn:tokenize($MESSAGE1, '@SM')
                         return
                                    if($j != 1 and $trama[1] != '') then(
                                 <INFO>
                                        {
                                             <NAME>{ fn:replace($trama[1],'[.]','_') }</NAME>,
                                            <VALUE>{ $trama[2] }</VALUE>,
                                            <STATUS>{ $trama[3] }</STATUS>
                                         }
                             </INFO>
                                 )else()
                    }
                 </INFO>    
                 };
                 
                 declare function obtenerInfoPrevious($dataNumber as xs:integer, $MESSAGE as xs:string, $number as xs:integer)
            as element(*){
               <INFO>
                   {
                      for $MESSAGE1 at $j in fn:tokenize(fn:tokenize(fn:tokenize($MESSAGE, '@PM')[$dataNumber], '@FM')[$number], '@VM')                                
                         let $trama := fn:tokenize($MESSAGE1, '@SM')
                         return
                                    if($j != 1 and $trama[1] != '') then(
                                 <INFO>
                                        {
                                             <NAME>{ fn:replace($trama[1],'[.]','_') }</NAME>,
                                            <VALUE>{ $trama[2] }</VALUE>
                                         }
                             </INFO>
                                 )else()
                    }
                 </INFO>    
                 };

declare function xf:registraDatosActualizadosIn($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:registraDatosActualizados) {
        <ns1:registraDatosActualizados>
        {
               let $x := fn:tokenize($procesaMensajeGenericoT241/MESSAGE, '@RM')
               return(
            <PROCESS_TYPE>{ $x[1] }</PROCESS_TYPE>,
            <OPERATION_TYPE>{ $x[2] }</OPERATION_TYPE>
            )
            }
            {
            let $customerData := fn:tokenize($procesaMensajeGenericoT241/MESSAGE, '\|\|')
                for $MESSAGE in $customerData
                return(
                    <CUSTOMER_DATA>
                       
                        <CUSTOMER_INFO>{ obtenerInfo(1, $MESSAGE, 2)/INFO }</CUSTOMER_INFO>,
                        <IDENTIFICATION_INFO>{ obtenerInfo(1, $MESSAGE, 3)/INFO }</IDENTIFICATION_INFO>,
                        {
                            for $data at $i in fn:tokenize(fn:tokenize($MESSAGE, '@PM')[1], '@FM')
                            return
                            if(fn:substring($data, 1, 12) = 'ADDRESS.INFO') then(
                            <ADDRESS_INFO>{ obtenerInfo(1, $MESSAGE, $i)/INFO }</ADDRESS_INFO>
                            )else if(fn:substring($data, 1, 10) = 'PHONE.INFO') then(
                            <PHONE_INFO>{ obtenerInfo(1, $MESSAGE, $i)/INFO }</PHONE_INFO>
                            )else if(fn:substring($data, 1, 10) = 'EMAIL.INFO') then(
                        <EMAIL_INFO>{ obtenerInfo(1, $MESSAGE, $i)/INFO }</EMAIL_INFO>  
                            )else if(fn:substring($data, 1, 12) = 'CONTROL.INFO') then(
                            <CONTROL_INFO>{ obtenerInfo(1, $MESSAGE, $i)/INFO }</CONTROL_INFO>
                            )else if(fn:substring($data, 1, 11) = 'SYSTEM.INFO') then(
                            <SYSTEM_INFO>{ obtenerInfo(1, $MESSAGE, $i)/INFO }</SYSTEM_INFO>
                            )else()
                        }
                        <PREVIOUS_DATA_INFO>
                         
                             <CUSTOMER_INFO>{ obtenerInfoPrevious(2, $MESSAGE, 2)/INFO }</CUSTOMER_INFO>,
                             <IDENTIFICATION_INFO>{ obtenerInfoPrevious(2, $MESSAGE, 3)/INFO }</IDENTIFICATION_INFO>,
                             {
                              for $data at $i in fn:tokenize(fn:tokenize($MESSAGE, '@PM')[2], '@FM')
                              return
                              if(fn:substring($data, 1, 12) = 'ADDRESS.INFO') then(
                            <ADDRESS_INFO>{ obtenerInfoPrevious(2, $MESSAGE, $i)/INFO }</ADDRESS_INFO>
                          )else if(fn:substring($data, 1, 10) = 'PHONE.INFO') then(
                          <PHONE_INFO>{ obtenerInfoPrevious(2, $MESSAGE, $i)/INFO }</PHONE_INFO>
                          )else if(fn:substring($data, 1, 10) = 'EMAIL.INFO') then(
                        <EMAIL_INFO>{ obtenerInfoPrevious(2, $MESSAGE, $i)/INFO }</EMAIL_INFO>  
                          )else()
                             }
                       </PREVIOUS_DATA_INFO>
                       
                    </CUSTOMER_DATA>
                   
                )
            }
        </ns1:registraDatosActualizados>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;

xf:registraDatosActualizadosIn($procesaMensajeGenericoT241)