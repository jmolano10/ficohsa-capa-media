(:: pragma bea:global-element-parameter parameter="$consultadedeudoresResponse" element="ns0:ConsultadedeudoresResponse" location="../Resources/XMLSchema_-2146193603.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDeudoresResponse" location="consultaDeudoresTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDeudoresTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/consultaDeudores/consultaDeudoresOut/";

declare function xf:consultaDeudoresOut($consultadedeudoresResponse as element(ns0:ConsultadedeudoresResponse))
    as element(ns1:consultaDeudoresResponse) {
        <ns1:consultaDeudoresResponse>
            <ns1:consultaDeudoresResponseType>
                {
                    for $mWSDEBTORLISTDetailType in $consultadedeudoresResponse/WSDEBTORLISTType[1]/gWSDEBTORLISTDetailType/mWSDEBTORLISTDetailType
                    return
                        <ns1:consultaDeudoresResponseRecordType>
                            {
                                for $SEVICENAME in $mWSDEBTORLISTDetailType/SEVICENAME
                                return
                                    <COLLECTION_NAME>{ data($SEVICENAME) }</COLLECTION_NAME>
                            }
                            {
                                for $DEBTORCODE in $mWSDEBTORLISTDetailType/DEBTORCODE
                                return
                                    <DEBTOR_CODE>{ data($DEBTORCODE) }</DEBTOR_CODE>
                            }
                            {
                                for $DEBTORNAME in $mWSDEBTORLISTDetailType/DEBTORNAME
                                return
                                    <DEBTOR_NAME>{ data($DEBTORNAME) }</DEBTOR_NAME>
                            }
                        </ns1:consultaDeudoresResponseRecordType>
                }
            </ns1:consultaDeudoresResponseType>
        </ns1:consultaDeudoresResponse>
};

declare variable $consultadedeudoresResponse as element(ns0:ConsultadedeudoresResponse) external;

xf:consultaDeudoresOut($consultadedeudoresResponse)