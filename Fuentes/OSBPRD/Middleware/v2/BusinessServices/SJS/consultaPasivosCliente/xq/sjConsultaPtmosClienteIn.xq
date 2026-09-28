(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteRequest1" element="ns1:sjConsultaPasivosClienteRequest" location="../xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaPrestamoTypeRequest" location="../../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace ns0 = "ConsultaPrestamosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xq/sjConsultaPtmosClienteIn/";

declare function xf:sjConsultaPtmosClienteIn($sjConsultaPasivosClienteRequest1 as element(ns1:sjConsultaPasivosClienteRequest))
    as element(ns0:ConsultaPrestamoTypeRequest) {
        <ns0:ConsultaPrestamoTypeRequest>
            <ns0:AUTHENTICATION_PROXY>
                <ns0:USERNAME>{ data($sjConsultaPasivosClienteRequest1/ns1:USERNAME) }</ns0:USERNAME>
                <ns0:PASSWORD>{ data($sjConsultaPasivosClienteRequest1/ns1:PASSWORD) }</ns0:PASSWORD>
            </ns0:AUTHENTICATION_PROXY>
            <ns0:PARAMETERS>
                <ns0:CUSTOMERID>{ data($sjConsultaPasivosClienteRequest1/ns1:CUSTOMER_ID) }</ns0:CUSTOMERID>
            </ns0:PARAMETERS>
        </ns0:ConsultaPrestamoTypeRequest>
};

declare variable $sjConsultaPasivosClienteRequest1 as element(ns1:sjConsultaPasivosClienteRequest) external;

xf:sjConsultaPtmosClienteIn($sjConsultaPasivosClienteRequest1)