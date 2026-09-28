(:: pragma bea:global-element-parameter parameter="$precualifyCustomerResponse" element="ns1:PrecualifyCustomerResponse" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/XMLSchema_-1613181781.xsd" ::)
(:: pragma bea:global-element-return element="ns3:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.FicohsaServices";
declare namespace ns1 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PrecalificacionCliente/xq/precalificacionClienteOut/";
declare namespace ns4 = "http://schemas.microsoft.com/2003/10/Serialization/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:precalificacionClienteOut($precualifyCustomerResponse as element(ns1:PrecualifyCustomerResponse))
    as element(ns3:ResponseHeader) {
        <ns3:ResponseHeader>
            {
                for $IdSaleForceRequest in $precualifyCustomerResponse/ns1:PrecualifyCustomerResult/ns0:ReturnObject/ns2:IdSaleForceRequest
                return
                    <transactionId>{ data($IdSaleForceRequest) }</transactionId>
            }
            {
                for $Status in $precualifyCustomerResponse/ns1:PrecualifyCustomerResult/ns0:Status
                return
                    <successIndicator>{ data($Status) }</successIndicator>
            }
            {
                for $RequestSubStatus in $precualifyCustomerResponse/ns1:PrecualifyCustomerResult/ns0:ReturnObject/ns2:RequestSubStatus
                return
                    <messages>{ data($RequestSubStatus) }</messages>
            }
        </ns3:ResponseHeader>
};

declare variable $precualifyCustomerResponse as element(ns1:PrecualifyCustomerResponse) external;

xf:precalificacionClienteOut($precualifyCustomerResponse)