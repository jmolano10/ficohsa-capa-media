(:: pragma bea:global-element-parameter parameter="$consultaLoteFacturas1" element="ns0:consultaLoteFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultaFacturasLoteCobranza/xsd/consultaFacturasLoteCobranza_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFacturasLoteCobranza";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteFacturas/xq/consultaFacturasLoteCobranzaIn/";

declare function xf:consultaFacturasLoteCobranzaIn($consultaLoteFacturas1 as element(ns0:consultaLoteFacturas))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCLIENTE>{ data($consultaLoteFacturas1/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
            <ns2:PV_NUMEROCONTRATO>{ data($consultaLoteFacturas1/CONTRACT_ID) }</ns2:PV_NUMEROCONTRATO>
            <ns2:PN_NUMEROLOTE>{ data($consultaLoteFacturas1/BANK_BATCH_ID) }</ns2:PN_NUMEROLOTE>
            <ns2:PN_PENDIENTE>1</ns2:PN_PENDIENTE>
            <ns2:PN_ANULADA>1</ns2:PN_ANULADA>
            <ns2:PN_ERROR>1</ns2:PN_ERROR>
            <ns2:PN_ELIMINADA>1</ns2:PN_ELIMINADA>
            <ns2:PN_PRE_ALTA>1</ns2:PN_PRE_ALTA>
            <ns2:PN_PRE_ELIMINADA>1</ns2:PN_PRE_ELIMINADA>
            <ns2:PN_PRE_ANULADA>1</ns2:PN_PRE_ANULADA>
            {
                let $paging := $consultaLoteFacturas1/PAGING_INFO/PAGING
                let $INITIAL_RECORD := $consultaLoteFacturas1/PAGING_INFO/INITIAL_RECORD
                let $RECORD_COUNT := $consultaLoteFacturas1/PAGING_INFO/RECORD_COUNT
                return
                    if ($paging = 'YES') then
                        (<ns2:PN_REGISTROINICIAL>{ data($INITIAL_RECORD) }</ns2:PN_REGISTROINICIAL>,
                         <ns2:PN_CANTIDADREGISTROS>{ data($RECORD_COUNT) }</ns2:PN_CANTIDADREGISTROS>)                        
                    else 
                        ()
            }
        </ns2:InputParameters>
};

declare variable $consultaLoteFacturas1 as element(ns0:consultaLoteFacturas) external;

xf:consultaFacturasLoteCobranzaIn($consultaLoteFacturas1)