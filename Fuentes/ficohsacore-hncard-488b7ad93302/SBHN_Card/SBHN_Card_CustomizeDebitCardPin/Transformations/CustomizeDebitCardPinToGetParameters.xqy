xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeDebitCardPinTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/utility/constants";
(:: import schema at "../../SBHN_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/CustomParameter.xsd" ::)

declare variable $CustomizeDebitCardPinToGetParameters as element() (:: schema-element(ns1:customizeDebitCardPin) ::) external;
declare variable $parametros as xs:string external;

declare function local:funcCustomizeDebitCardPinToGetParameters($CustomizeDebitCardPinToGetParameters as element() (:: schema-element(ns1:customizeDebitCardPin) ::),
                                                                $parametros as xs:string) as element() (:: schema-element(ns2:GetParameters) ::) {
    <ns2:GetParameters>
                <ns2:parameterName>
                {$parametros}
                </ns2:parameterName>
    </ns2:GetParameters>
};

local:funcCustomizeDebitCardPinToGetParameters($CustomizeDebitCardPinToGetParameters, $parametros)
