(:: pragma bea:global-element-parameter parameter="$consultaCatalogosCB" element="ns0:consultaCatalogos" location="../xsd/consultaCatalogosCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCatalogos" location="../../ConsultaCatalogos/xsd/consultaCatalogosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCatalogosCB/xq/consultaCatalogosCBIn/";

declare function xf:consultaCatalogosCBIn($consultaCatalogosCB as element(ns0:consultaCatalogos))
    as element(ns1:consultaCatalogos) {
        <ns1:consultaCatalogos>
            {
                for $REMITTER_ID in $consultaCatalogosCB/ns0:REMITTER_ID
                return
                    <ns1:REMITTER_ID>{ data($REMITTER_ID) }</ns1:REMITTER_ID>
            }
            {
                let $FILTERS := $consultaCatalogosCB/ns0:FILTERS
                return
                    <ns1:FILTERS>
                        {
                            for $FILTER in $FILTERS/ns0:FILTER
                            return
                                <ns1:FILTER>{ data($FILTER) }</ns1:FILTER>
                        }
                    </ns1:FILTERS>
            }
        </ns1:consultaCatalogos>
};

declare variable $consultaCatalogosCB as element(ns0:consultaCatalogos) external;

xf:consultaCatalogosCBIn($consultaCatalogosCB)
