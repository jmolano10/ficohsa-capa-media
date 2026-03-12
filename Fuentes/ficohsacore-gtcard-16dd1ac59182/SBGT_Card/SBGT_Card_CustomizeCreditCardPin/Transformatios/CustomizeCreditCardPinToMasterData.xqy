xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/MasterData_dbAdapter";
(:: import schema at "../Schemas/MasterData_dbAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/guatemala/card";
(:: import schema at "../Schemas/CustomizeCreditCardPin.xsd" ::)

declare variable $CustomizeCreditCardPinToMasterData as element() (:: schema-element(ns1:customizeCreditCardPin) ::) external;

declare function local:funcCustomizeCreditCardPinToMasterData($CustomizeCreditCardPinToMasterData as element() (:: schema-element(ns1:customizeCreditCardPin) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($CustomizeCreditCardPinToMasterData/GeneralInfo/SourceBank/text() = 'GT01')
            then <Pais>{'GTM'}</Pais>
            else ()
        }
        <NumTarjeta>{fn:data($CustomizeCreditCardPinToMasterData/CardNumber)}</NumTarjeta>
    </ns2:InputParameters>
};

local:funcCustomizeCreditCardPinToMasterData($CustomizeCreditCardPinToMasterData)