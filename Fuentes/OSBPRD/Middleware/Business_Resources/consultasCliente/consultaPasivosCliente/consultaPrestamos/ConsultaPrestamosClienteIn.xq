(:: pragma bea:global-element-parameter parameter="$consultaPrestamoTypeRequest1" element="ns0:ConsultaPrestamoTypeRequest" location="ConsultaPrestamosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace ns0 = "ConsultaPrestamosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/ConsultaPrestamosClienteIn/";

declare function xf:ConsultaPrestamosClienteIn($consultaPrestamoTypeRequest1 as element(ns0:ConsultaPrestamoTypeRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CUSTOMER_ID>{ data($consultaPrestamoTypeRequest1/ns0:PARAMETERS/ns0:CUSTOMERID[1]) }</ns1:CUSTOMER_ID>
            <ns1:LIABILITY_TYPE>PTM</ns1:LIABILITY_TYPE>
        </ns1:InputParameters>
};

declare variable $consultaPrestamoTypeRequest1 as element(ns0:ConsultaPrestamoTypeRequest) external;

xf:ConsultaPrestamosClienteIn($consultaPrestamoTypeRequest1)