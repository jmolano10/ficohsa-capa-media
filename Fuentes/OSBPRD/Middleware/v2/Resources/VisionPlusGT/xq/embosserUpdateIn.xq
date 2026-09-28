(:: pragma bea:global-element-return element="ns0:EmbosserUpdateRequest" location="../../../BusinessServices/VisionPlusGT/vmx/wsdl/VMX.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/embosserUpdateIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:embosserUpdateIn($org as xs:string,
    $cardNumber as xs:string,
    $blockReason as xs:string,
    $numCliente as xs:string,
    $blockCode as xs:string)
    as element(ns0:EmbosserUpdateRequest) {
         <ns0:EmbosserUpdateRequest>
            <ARXEUI-ORG>{ data($org) }</ARXEUI-ORG>
            <ARXEUI-CARD-NBR>{ $cardNumber }</ARXEUI-CARD-NBR>
            <ARXEUI-CARD-SEQ>1</ARXEUI-CARD-SEQ>
            <ARXEUI-FOREIGN-USE>0</ARXEUI-FOREIGN-USE>
            <ARXEUI-CUSTOMER-NBR>{ data ($numCliente) }</ARXEUI-CUSTOMER-NBR>
            <ARXEUI-USER-4>{ $blockReason }</ARXEUI-USER-4>
            {
            	if($blockCode = 'O' and ($blockReason = '04' or $blockReason = '4')) then
            		<ARXEUI-USER-7>4</ARXEUI-USER-7>
          		else
          			<ARXEUI-USER-7></ARXEUI-USER-7>
            }
        </ns0:EmbosserUpdateRequest>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $blockReason as xs:string external;
declare variable $numCliente as xs:string external;
declare variable $blockCode as xs:string external;

xf:embosserUpdateIn($org,
    $cardNumber,
    $blockReason,
    $numCliente,
    $blockCode)