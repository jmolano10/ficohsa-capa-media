(:: pragma bea:global-element-parameter parameter="$consultadeactividadeconomicaResponse1" element="ns1:ConsultadeactividadeconomicaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaActividadEconomicaResponse" location="consultaActividadEconomicaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaActividadEconomicaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaActividadEconomica/consultaActividadEconomicaOut/";

declare function xf:consultaActividadEconomicaOut($consultadeactividadeconomicaResponse1 as element(ns1:ConsultadeactividadeconomicaResponse))
    as element(ns0:consultaActividadEconomicaResponse) {
        <ns0:consultaActividadEconomicaResponse>
            <ns0:consultaActividadEconomicaResponseType>
                {
                    for $mWSECONACTIVITYLISTDetailType in $consultadeactividadeconomicaResponse1/WSECONACTIVITYLISTType[1]/gWSECONACTIVITYLISTDetailType/mWSECONACTIVITYLISTDetailType
                    return
                        <ns0:consultaActividadEconomicaResponseRecordType>
                            {
                                for $ID in $mWSECONACTIVITYLISTDetailType/ID
                                return
                                    <ECONACTIVITY_ID>{ data($ID) }</ECONACTIVITY_ID>
                            }
                            {
                                for $DESCRIPTION in $mWSECONACTIVITYLISTDetailType/DESCRIPTION
                                return
                                    <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                            }
                            {
                                for $SECTORLEVEL in $mWSECONACTIVITYLISTDetailType/SECTORLEVEL
                                return
                                    <ACTIVITY_LEVEL>{ data($SECTORLEVEL) }</ACTIVITY_LEVEL>
                            }
                        </ns0:consultaActividadEconomicaResponseRecordType>
                }
            </ns0:consultaActividadEconomicaResponseType>
        </ns0:consultaActividadEconomicaResponse>
};

declare variable $consultadeactividadeconomicaResponse1 as element(ns1:ConsultadeactividadeconomicaResponse) external;

xf:consultaActividadEconomicaOut($consultadeactividadeconomicaResponse1)