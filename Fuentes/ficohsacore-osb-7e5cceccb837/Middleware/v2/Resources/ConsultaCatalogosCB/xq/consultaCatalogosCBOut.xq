(:: pragma bea:global-element-parameter parameter="$consultaCatalogosResponse" element="ns1:consultaCatalogosResponse" location="../../ConsultaCatalogos/xsd/consultaCatalogosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCatalogosResponse" location="../xsd/consultaCatalogosCBTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCatalogosCB/xq/consultaCatalogosCBOut/";

declare function xf:consultaCatalogosCBOut($consultaCatalogosResponse as element(ns1:consultaCatalogosResponse))
    as element(ns0:consultaCatalogosResponse) {
        <ns0:consultaCatalogosResponse>
            {
                for $catalogsList in $consultaCatalogosResponse/ns1:catalogsList
                return
                    <ns0:catalogsList id = "{ data($catalogsList/@id) }">
                        {
                            for $catalogItem in $catalogsList/ns1:catalogItem
                            return
                                <ns0:catalogItem>
                                    {
                                        for $CODE in $catalogItem/ns1:CODE
                                        return
                                            <ns0:CODE>{ data($CODE) }</ns0:CODE>
                                    }
                                    {
                                        for $DESCRIPTION in $catalogItem/ns1:DESCRIPTION
                                        return
                                            <ns0:DESCRIPTION>{ data($DESCRIPTION) }</ns0:DESCRIPTION>
                                    }
                                </ns0:catalogItem>
                        }
                    </ns0:catalogsList>
            }
        </ns0:consultaCatalogosResponse>
};

declare variable $consultaCatalogosResponse as element(ns1:consultaCatalogosResponse) external;

xf:consultaCatalogosCBOut($consultaCatalogosResponse)
