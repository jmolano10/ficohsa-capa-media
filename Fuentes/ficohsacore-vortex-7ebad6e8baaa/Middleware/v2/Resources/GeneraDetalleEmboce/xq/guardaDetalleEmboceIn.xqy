xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEBITCARD/guardaDetalleEmboce/xsd/guardaDetalleEmboce_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardaDetalleEmboce";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/guardaDetalleEmboceIn/";

declare function xf:guardaDetalleEmboceIn($instructionReference as xs:string,
    $InstructionData as xs:string,
    $country as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_INSTRUCTIONS_REFERENCE>{ $instructionReference }</ns0:PV_INSTRUCTIONS_REFERENCE>
            <ns0:P_INSTRUCTIONS_DATA>{ $InstructionData }</ns0:P_INSTRUCTIONS_DATA>
            <ns0:PV_COUNTRY>{ $country }</ns0:PV_COUNTRY>
        </ns0:InputParameters>
};

declare variable $instructionReference as xs:string external;
declare variable $InstructionData as xs:string external;
declare variable $country as xs:string external;

xf:guardaDetalleEmboceIn($instructionReference,
    $InstructionData,
    $country)