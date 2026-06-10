<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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

xf:consultaCatalogoIn($consultaCatalogosIN)]]></con:xquery>
    <con:dependency location="../xsd/consultaCatalogosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaCatalogos/xsd/consultaCatalogosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Remesas/consultaCatalogos/xsd/consultaCatalogo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Remesas/consultaCatalogos/xsd/consultaCatalogo_sp"/>
    </con:dependency>
</con:xqueryEntry>