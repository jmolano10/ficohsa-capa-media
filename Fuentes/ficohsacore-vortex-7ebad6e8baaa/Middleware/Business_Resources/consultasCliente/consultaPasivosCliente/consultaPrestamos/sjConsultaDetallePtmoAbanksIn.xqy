xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGeneralPrestamo" location="../../../consultaGeneralPrestamo/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaGeneralPrestamoIn/";

declare function xf:ConsultaGeneralPrestamoIn($outputParameters1 as element(ns1:OutputParameters),
    $counter as xs:integer)
    as element(ns0:consultaGeneralPrestamo) {
        <ns0:consultaGeneralPrestamo>
        	{
	        	for $ITEM in $outputParameters1/ns1:LIABILITY_NUMBER/ns1:ITEM[xs:int($counter)]
	            return
	            <LOAN_ID>{ data($ITEM) }</LOAN_ID>
        	}
        </ns0:consultaGeneralPrestamo>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $counter as xs:integer external;

xf:ConsultaGeneralPrestamoIn($outputParameters1,
    $counter)