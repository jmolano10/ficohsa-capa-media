xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/GetLockedFundsDetails/XMLSchema_-955040778.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/honduras/user";
(:: import schema at "../../SBHN_Card_Commons/Schemas/UserLoginT24.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $consultaDetalleSaldosPignorados as element() (:: schema-element(ns2:getLockedFundsDetails) ::) external;
declare variable $requestHeader as element() (:: schema-element(ns0:connInfoElement) ::) external;

declare function local:func($consultaDetalleSaldosPignorados as element() (:: schema-element(ns2:getLockedFundsDetails) ::), 
                            $requestHeader as element() (:: schema-element(ns0:connInfoElement) ::)) 
                            as element() (:: schema-element(ns1:getLockedFundsDetails) ::) {
        <ns1:getLockedFundsDetails>
              <WebRequestCommon>
            <userName>{fn:data($requestHeader/ns0:username)}</userName>
            <password>{fn:data($requestHeader/ns0:password)}</password>
            </WebRequestCommon>
            <WSFICOECUSTPOSVISATXNSType>
                <enquiryInputCollection>
                	<columnName>ACCOUNT.NUMBER</columnName>
                    <criteriaValue>{ data($consultaDetalleSaldosPignorados/AccountNumber) }</criteriaValue>
                    <operand>EQ</operand> 
                </enquiryInputCollection>
                <enquiryInputCollection>
               		<columnName>NATURE.OF.TXN</columnName>
               		<criteriaValue>ATM POS</criteriaValue>
               		<operand>NE</operand>
            	</enquiryInputCollection>
            </WSFICOECUSTPOSVISATXNSType>
        </ns1:getLockedFundsDetails>
};

local:func($consultaDetalleSaldosPignorados, $requestHeader)