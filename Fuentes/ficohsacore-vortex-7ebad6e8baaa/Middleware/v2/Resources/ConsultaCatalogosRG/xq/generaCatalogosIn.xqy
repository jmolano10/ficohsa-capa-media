xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCatalogosRG" element="ns1:consultaCatalogosRG" location="../../ConsultaCatalogosRegionales/xsd/consultaCatalogosRegionalesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/generaCatalogos/xsd/generaCatalogos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generaCatalogos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosRegionalesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCatalogosRG/xq/generaCatalogosIn/";

declare function xf:generaCatalogosIn($consultaCatalogosRG as element(ns1:consultaCatalogosRG))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
            for $consultaCatalogos in $consultaCatalogosRG/CATALOGUES_INFO/CATALOGUE
            return(
            
            <ns0:PV_NAME>{ data($consultaCatalogos/NAME) }</ns0:PV_NAME>,
            <ns0:PV_SOURCE_SYSTEM>{ data($consultaCatalogos/SOURCE_SYSTEM) }</ns0:PV_SOURCE_SYSTEM>,
            <ns0:PV_SOURCE_BANK>{ data($consultaCatalogos/SOURCE_BANK) }</ns0:PV_SOURCE_BANK>,
            <ns0:PN_INITIAL_RECORD>{ data($consultaCatalogos/PAGING_INFO/INITIAL_RECORD) }</ns0:PN_INITIAL_RECORD>,
            <ns0:PN_RECORD_COUNT>{ data($consultaCatalogos/PAGING_INFO/RECORD_COUNT) }</ns0:PN_RECORD_COUNT>,
            <ns0:PR_FILTER_CRITERIAS>
                <ns0:FILTER_CRITERIAS>
                         {
                            for $criterias in $consultaCatalogos/FILTER_CRITERIAS
                            return
                              <ns0:FILTER_CRITERIAS_ITEM>
                                     <ns0:TYPE_FILTER>{ data($criterias/TYPE_FILTER) }</ns0:TYPE_FILTER>
                                     <ns0:VALUE_FILTER>{ data($criterias/VALUE_FILTER) }</ns0:VALUE_FILTER>
                               </ns0:FILTER_CRITERIAS_ITEM>
                             }
                </ns0:FILTER_CRITERIAS>
            </ns0:PR_FILTER_CRITERIAS>
            )}
        </ns0:InputParameters>
};

declare variable $consultaCatalogosRG as element(ns1:consultaCatalogosRG) external;

xf:generaCatalogosIn($consultaCatalogosRG)