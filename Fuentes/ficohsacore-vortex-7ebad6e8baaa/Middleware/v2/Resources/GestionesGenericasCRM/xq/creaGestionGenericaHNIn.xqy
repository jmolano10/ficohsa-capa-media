xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionesGenericasCRM" element="ns1:gestionesGenericasCRM" location="../xsd/gestionesGenericasCRMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ws_gestiones" location="../../../BusinessServices/SALESFORCE/creaGestionGenerica/wsdl/creaGestionGenerica.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/ws_gestiones";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesGenericasCRM/xq/creaGestionGenericaHNIn/";

declare function xf:creaGestionGenericaHNIn($gestionesGenericasCRM as element(ns1:gestionesGenericasCRM),
    $country as xs:string,
    $brach as xs:string,
    $equivalencia as xs:string)
    as element(ns0:ws_gestiones) {
        <ns0:ws_gestiones>
            <ns0:parameters>
                {
                    for $KV_PAIRS in $gestionesGenericasCRM/KV_PAIRS/KV_PAIR
                    return
                        <ns0:field>
                            <ns0:key>{ data($KV_PAIRS/KEY) }</ns0:key>
                            <ns0:value>{ data($KV_PAIRS/VALUE) }</ns0:value>
                        </ns0:field>
                }
            </ns0:parameters>
            <ns0:country>{ $country }</ns0:country>
            <ns0:branch>{ $brach }</ns0:branch>
            <ns0:type>{ $equivalencia }</ns0:type>
            <ns0:next_step>REFERIR</ns0:next_step>
        </ns0:ws_gestiones>
};

declare variable $gestionesGenericasCRM as element(ns1:gestionesGenericasCRM) external;
declare variable $country as xs:string external;
declare variable $brach as xs:string external;
declare variable $equivalencia as xs:string external;

xf:creaGestionGenericaHNIn($gestionesGenericasCRM,
    $country,
    $brach,
    $equivalencia)