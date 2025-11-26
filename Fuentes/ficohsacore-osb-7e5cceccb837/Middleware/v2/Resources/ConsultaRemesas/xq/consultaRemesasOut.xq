xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaderemesaResponse" element="ns1:ConsultaderemesaResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesasOut/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";

declare function xf:consultaRemesasOut($consultaderemesaResponse as element(ns1:ConsultaderemesaResponse))
    as element(ns0:consultaRemesasResponse) {
        let $WSLATAMAGREMITTANCEINFOType := $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]
        return
            <ns0:consultaRemesasResponse>
                {
                    for $gWSLATAMAGREMITTANCEINFODetailType in $WSLATAMAGREMITTANCEINFOType/gWSLATAMAGREMITTANCEINFODetailType
                    return
                        <ns0:consultaRemesasResponseType>
                            {
                                for $mWSLATAMAGREMITTANCEINFODetailType in $gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType
                                return
                                    <ns0:consultaRemesasResponseRecordType>
                                        {
                                            for $REMITTANCEKEY in $mWSLATAMAGREMITTANCEINFODetailType/REMITTANCEKEY
                                            return
                                                <REMITTANCE_ID>{ data($REMITTANCEKEY) }</REMITTANCE_ID>
                                        }
                                        {
                                            for $STATUS in $mWSLATAMAGREMITTANCEINFODetailType/STATUS
                                            return
                                                <REMITTANCE_STATUS>{ data($STATUS) }</REMITTANCE_STATUS>
                                        }
                                        <REMITTANCE_SOURCE_AMOUNT></REMITTANCE_SOURCE_AMOUNT> 
                                    </ns0:consultaRemesasResponseRecordType>
                            }                           
                        </ns0:consultaRemesasResponseType>
                }
            </ns0:consultaRemesasResponse>
};

declare variable $consultaderemesaResponse as element(ns1:ConsultaderemesaResponse) external;

xf:consultaRemesasOut($consultaderemesaResponse)