(:: pragma bea:global-element-parameter parameter="$consultaderemesaResponse" element="ns1:ConsultaderemesaResponse" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="consultaRemesasTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasOut/";

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
                                            for $ORDPARTYNAME in $mWSLATAMAGREMITTANCEINFODetailType/ORDPARTYNAME
                                            return
                                                <REMITTER_NAME>{ data($ORDPARTYNAME) }</REMITTER_NAME>
                                        }
                                        {
                                            for $BENEFICIARY in $mWSLATAMAGREMITTANCEINFODetailType/BENEFICIARY
                                            return
                                                <BENEFICIARY_NAME>{ data($BENEFICIARY) }</BENEFICIARY_NAME>
                                        }
                                        {
                                            for $STATUS in $mWSLATAMAGREMITTANCEINFODetailType/STATUS
                                            return
                                                <REMITTANCE_STATUS>{ data($STATUS) }</REMITTANCE_STATUS>
                                        }
                                    </ns0:consultaRemesasResponseRecordType>
                            }
                        </ns0:consultaRemesasResponseType>
                }
            </ns0:consultaRemesasResponse>
};

declare variable $consultaderemesaResponse as element(ns1:ConsultaderemesaResponse) external;

xf:consultaRemesasOut($consultaderemesaResponse)