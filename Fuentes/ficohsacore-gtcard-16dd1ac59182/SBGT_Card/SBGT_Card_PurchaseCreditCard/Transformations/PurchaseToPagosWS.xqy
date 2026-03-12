xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBRegBrokerAdapter";
(:: import schema at "../Schemas/DBRegBrokerAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $PurchaseCreditCard as element() (:: schema-element(ns1:purchaseCreditCard) ::) external;
declare variable $org as xs:string external;
declare variable $sequence as xs:string external;

declare function local:funcPurchaseToPagosWS($PurchaseCreditCard as element() (:: schema-element(ns1:purchaseCreditCard) ::),
                                              $org as xs:string,
                                              $sequence as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <PV_TICKET>{fn:data($PurchaseCreditCard/Ticket)}</PV_TICKET>
        <PV_ESTADO_TICKET>P</PV_ESTADO_TICKET>
        <PV_MERCHANTNUMBER>{fn:data($PurchaseCreditCard/MerchantNumber)}</PV_MERCHANTNUMBER>
        <PV_NUMEROTARJETA>{fn:data($PurchaseCreditCard/CreditCard)}</PV_NUMEROTARJETA>
        <PV_TIPOOPERACION>{fn:data($PurchaseCreditCard/OperationType)}</PV_TIPOOPERACION>
        {
          if (fn:data($PurchaseCreditCard/BalanceCurrency/text() = 'GTQ')) 
            then (<PN_TIPOMONEDA>13</PN_TIPOMONEDA>)
          else()
        }
        {
          if (fn:data($PurchaseCreditCard/BalanceCurrency/text() = 'USD')) 
            then (<PN_TIPOMONEDA>2</PN_TIPOMONEDA>)
          else()
        }
        <PN_ORGANIZACION>{fn:data($org)}</PN_ORGANIZACION>
        <PV_MONEDATRANSACCION>{fn:data($PurchaseCreditCard/TransactionCurrency)}</PV_MONEDATRANSACCION>
        <PN_TASACAMBIO>{fn:data($PurchaseCreditCard/ExchangeRate)}</PN_TASACAMBIO>
        <PN_TIPOTRANSACCION>{fn:data($PurchaseCreditCard/TransactionType)}</PN_TIPOTRANSACCION>
        <PV_CODIGOUSUARIO>{fn:data($PurchaseCreditCard/UserCode)}</PV_CODIGOUSUARIO>
        <PV_SECUENCIAMOVIMIENTO>{fn:data($sequence)}</PV_SECUENCIAMOVIMIENTO>
        <PV_SECUENCIAORIGEN>{fn:data($PurchaseCreditCard/OriginSequence)}</PV_SECUENCIAORIGEN>
        <PN_VALOREFECTIVO>{fn:data($PurchaseCreditCard/PaymentAmount)}</PN_VALOREFECTIVO>
        {
            if ($PurchaseCreditCard/GeneralInfo/SourceBank)
            then <PV_BANCOORIGEN>{fn:data($PurchaseCreditCard/GeneralInfo/SourceBank/text())}</PV_BANCOORIGEN>
            else ()
        }
        {
            if ($PurchaseCreditCard/GeneralInfo/DestinationBank)
            then <PV_BANCODESTINO>{fn:data($PurchaseCreditCard/GeneralInfo/DestinationBank/text())}</PV_BANCODESTINO>
            else ()
        }
        <PV_DESCRIPCIONTRANSACCION>{fn:data($PurchaseCreditCard/Description)}</PV_DESCRIPCIONTRANSACCION>
        <PV_CANAL>{fn:data($PurchaseCreditCard/ChannelCode)}</PV_CANAL>
        <PV_NUMEROAUTORIZACION>{fn:data($PurchaseCreditCard/AuthorizationNumber)}</PV_NUMEROAUTORIZACION>
        <PV_APLICADO>{fn:data($PurchaseCreditCard/Applied)}</PV_APLICADO>
        <PV_APLICARENLINEA>{fn:data($PurchaseCreditCard/AppliedOnLine)}</PV_APLICARENLINEA>
        <PV_FECHAEXPTC>{fn:data($PurchaseCreditCard/CardExpirationDate)}</PV_FECHAEXPTC>
    </ns2:InputParameters>
};

local:funcPurchaseToPagosWS($PurchaseCreditCard,$org,$sequence)