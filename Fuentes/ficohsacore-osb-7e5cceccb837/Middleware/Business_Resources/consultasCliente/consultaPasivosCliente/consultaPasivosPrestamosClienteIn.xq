(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest" element="ns1:consultaPasivosClienteRequest" location="../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPasivosPrestamosClienteIn/";

declare function xf:consultaPasivosPrestamosClienteIn($consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($consultaPasivosClienteRequest/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:LIABILITY_TYPE>{ data($consultaPasivosClienteRequest/LIABILITY_TYPE) }</ns0:LIABILITY_TYPE>
        </ns0:InputParameters>
};

declare variable $consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaPasivosPrestamosClienteIn($consultaPasivosClienteRequest)