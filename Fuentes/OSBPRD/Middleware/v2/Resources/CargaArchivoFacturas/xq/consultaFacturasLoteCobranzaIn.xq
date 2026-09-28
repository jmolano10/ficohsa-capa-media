(:: pragma bea:global-element-parameter parameter="$cargaArchivoFacturas1" element="ns1:cargaArchivoFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/registrarFacturaCobranzas/xsd/registrarFacturaCobranzas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultaFacturasLoteCobranza/xsd/consultaFacturasLoteCobranza_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarFacturaCobranzas";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFacturasLoteCobranza";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoFacturas/xq/consultaFacturasLoteCobranzaIn/";

declare function xf:consultaFacturasLoteCobranzaIn($cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCLIENTE>{ data($cargaArchivoFacturas1/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
            <ns2:PV_NUMEROCONTRATO>{ data($cargaArchivoFacturas1/CONTRACT_ID) }</ns2:PV_NUMEROCONTRATO>
            {
                for $PN_NUMEROLOTE in $outputParameters1/ns0:PN_NUMEROLOTE
                return
                    <ns2:PN_NUMEROLOTE>{ data($PN_NUMEROLOTE) }</ns2:PN_NUMEROLOTE>
            }
            <ns2:PN_PENDIENTE>1</ns2:PN_PENDIENTE>
			<ns2:PN_ANULADA>1</ns2:PN_ANULADA>
			<ns2:PN_ERROR>1</ns2:PN_ERROR>
			<ns2:PN_ELIMINADA>1</ns2:PN_ELIMINADA>
			<ns2:PN_PRE_ALTA>1</ns2:PN_PRE_ALTA>
			<ns2:PN_PRE_ELIMINADA>1</ns2:PN_PRE_ELIMINADA>
			<ns2:PN_PRE_ANULADA>1</ns2:PN_PRE_ANULADA>
        </ns2:InputParameters>
};

declare variable $cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaFacturasLoteCobranzaIn($cargaArchivoFacturas1,
    $outputParameters1)