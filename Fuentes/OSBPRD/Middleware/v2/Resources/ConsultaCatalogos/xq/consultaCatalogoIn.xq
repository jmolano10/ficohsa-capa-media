(:: pragma bea:global-element-parameter parameter="$consultaCatalogosIN" element="ns0:consultaCatalogos" location="../xsd/consultaCatalogosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Remesas/consultaCatalogos/xsd/consultaCatalogo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCatalogo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCatalogos/xq/consultaCatalogoIn/";

declare function xf:consultaCatalogoIn($consultaCatalogosIN as element(ns0:consultaCatalogos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                let $FILTERS := $consultaCatalogosIN/ns0:FILTERS
                return
                    <ns1:PT_NOMBRES_CATALOGOS>
                        {
                            for $FILTER in $FILTERS/ns0:FILTER
                            return
                                <ns1:PT_NOMBRES_CATALOGOS_ITEM>{ data($FILTER) }</ns1:PT_NOMBRES_CATALOGOS_ITEM>
                        }
                    </ns1:PT_NOMBRES_CATALOGOS>
            }
            {
                for $REMITTER_ID in $consultaCatalogosIN/ns0:REMITTER_ID
                return
                    <ns1:PV_ID_CONTRATO_T24>{ data($REMITTER_ID) }</ns1:PV_ID_CONTRATO_T24>
            }
        </ns1:InputParameters>
};

declare variable $consultaCatalogosIN as element(ns0:consultaCatalogos) external;

xf:consultaCatalogoIn($consultaCatalogosIN)