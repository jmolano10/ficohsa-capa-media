<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMultipleDatosResponse" element="ns1:procesaMultipleDatosResponse" location="../../OperacionesCriptograficas/xsd/operacionesCriptograficasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboceResponse" element="ns0:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/armaResponseGeneraDetalleEmboceWS/";

declare function xf:armaResponseGeneraDetalleEmboceWS($procesaMultipleDatosResponse as element(ns1:procesaMultipleDatosResponse),
    $generaDetalleEmboceResponse as element(ns0:generaDetalleEmboceResponse))
    as element(ns0:generaDetalleEmboceResponse) {
        <ns0:generaDetalleEmboceResponse>
            <status>{ data($generaDetalleEmboceResponse/status) }</status>
            <message>{ data($generaDetalleEmboceResponse/message) }</message>
            <cardDetailsResponse>
                {
                    for $cardItemResponse in $generaDetalleEmboceResponse/cardDetailsResponse/cardItemResponse
                    return
                        <cardItemResponse>
                            <cardNumber>{ data($cardItemResponse/cardNumber) }</cardNumber>
                            <bin>{ data($cardItemResponse/bin) }</bin>
                            <nameOnCard>{ data($cardItemResponse/nameOnCard) }</nameOnCard>
                            <serviceCode>{ data($cardItemResponse/serviceCode) }</serviceCode>
                            <pinBlock>{ data($cardItemResponse/pinBlock) }</pinBlock>
                            <pin>
                                {
                                    fn:string($procesaMultipleDatosResponse/ns1:DATA_ITEMS/ns1:FIELD_ITEM[
                                    ns1:NAME = fn:concat(data($cardItemResponse/cardNumber), '.pin')]/ns1:VALUE/text())
                                }
							</pin>
                            <instructionDetails>
                                {
                                    for $generationItem in $cardItemResponse/instructionDetails/generationItem
                                    return
                                        <generationItem>
                                            <generatedInstruction>{ data($generationItem/generatedInstruction) }</generatedInstruction>
                                            <generatedValue>
                                                {
                                                    fn:string($procesaMultipleDatosResponse/ns1:DATA_ITEMS/ns1:FIELD_ITEM[
                                                    ns1:NAME = fn:concat(data($cardItemResponse/cardNumber), '.', data($generationItem/generatedInstruction))]/ns1:VALUE/text())
                                                }
											</generatedValue>
                                            <generatedValueStatus>{ data($generationItem/generatedValueStatus) }</generatedValueStatus>
                                            <generatedValueMessage>{ data($generationItem/generatedValueMessage) }</generatedValueMessage>
                                        </generationItem>
                                }
                            </instructionDetails>
                        </cardItemResponse>
                }
            </cardDetailsResponse>
        </ns0:generaDetalleEmboceResponse>
};

declare variable $procesaMultipleDatosResponse as element(ns1:procesaMultipleDatosResponse) external;
declare variable $generaDetalleEmboceResponse as element(ns0:generaDetalleEmboceResponse) external;

xf:armaResponseGeneraDetalleEmboceWS($procesaMultipleDatosResponse,
    $generaDetalleEmboceResponse)]]></con:xquery>
    <con:dependency location="../../OperacionesCriptograficas/xsd/operacionesCriptograficasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCriptograficas/xsd/operacionesCriptograficasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices"/>
    </con:dependency>
</con:xqueryEntry>