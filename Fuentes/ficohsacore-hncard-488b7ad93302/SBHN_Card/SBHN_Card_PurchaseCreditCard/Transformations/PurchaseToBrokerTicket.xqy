xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBRegBrokerTicketAdapter";
(:: import schema at "../Schemas/DBRegBrokerTicketAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:purchaseCreditCard) ::) external;
declare variable $org as xs:string external;
declare variable $sequence as xs:string external;

declare function local:funcPurchaseToBrokerTicket($input as element() (:: schema-element(ns1:purchaseCreditCard) ::),
                                              $org as xs:string,
                                              $sequence as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_TICKET>{fn:data($input/Ticket)}</ns2:PV_TICKET>
        <ns2:PV_ESTADO_TICKET>P</ns2:PV_ESTADO_TICKET>
        <ns2:PV_MERCHANTNUMBER>{fn:data($input/MerchantNumber)}</ns2:PV_MERCHANTNUMBER>
        <ns2:PV_NUMEROTARJETA>{fn:data($input/CreditCard)}</ns2:PV_NUMEROTARJETA>
        <ns2:PV_TIPOOPERACION>{fn:data($input/OperationType)}</ns2:PV_TIPOOPERACION>
        {
          if (fn:data($input/BalanceCurrency/text() = 'HNL')) 
            then (<ns2:PN_TIPOMONEDA>1</ns2:PN_TIPOMONEDA>)
          else()
        }
        {
          if (fn:data($input/BalanceCurrency/text() = 'USD')) 
            then (<ns2:PN_TIPOMONEDA>2</ns2:PN_TIPOMONEDA>)
          else()
        }
        <ns2:PN_ORGANIZACION>{fn:data($org)}</ns2:PN_ORGANIZACION>
        <ns2:PV_MONEDATRANSACCION>{fn:data($input/TransactionCurrency)}</ns2:PV_MONEDATRANSACCION>
        <ns2:PN_TASACAMBIO>{fn:data($input/ExchangeRate)}</ns2:PN_TASACAMBIO>
        <ns2:PN_TIPOTRANSACCION>{fn:data($input/TransactionType)}</ns2:PN_TIPOTRANSACCION>
        <ns2:PV_CODIGOUSUARIO>{fn:data($input/UserCode)}</ns2:PV_CODIGOUSUARIO>
        <ns2:PV_SECUENCIAMOVIMIENTO>{fn:data($sequence)}</ns2:PV_SECUENCIAMOVIMIENTO>
        <ns2:PV_SECUENCIAORIGEN>{fn:data($input/OriginSequence)}</ns2:PV_SECUENCIAORIGEN>
        <ns2:PN_VALOREFECTIVO>{fn:data($input/PaymentAmount)}</ns2:PN_VALOREFECTIVO>
        {
            if ($input/GeneralInfo/SourceBank)
            then <ns2:PV_BANCOORIGEN>{fn:data($input/GeneralInfo/SourceBank)}</ns2:PV_BANCOORIGEN>
            else ()
        }
        {
            if ($input/GeneralInfo/DestinationBank)
            then <ns2:PV_BANCODESTINO>{fn:data($input/GeneralInfo/DestinationBank)}</ns2:PV_BANCODESTINO>
            else ()
        }
        <ns2:PV_DESCRIPCIONTRANSACCION>{fn:data($input/Description)}</ns2:PV_DESCRIPCIONTRANSACCION>
        <ns2:PV_CANAL>{fn:data($input/ChannelCode)}</ns2:PV_CANAL>
        <ns2:PV_NUMEROAUTORIZACION>{fn:data($input/AuthorizationNumber)}</ns2:PV_NUMEROAUTORIZACION>
        <ns2:PV_APLICADO>{fn:data($input/Applied)}</ns2:PV_APLICADO>
        <ns2:PV_APLICARENLINEA>{fn:data($input/AppliedOnLine)}</ns2:PV_APLICARENLINEA>
        <ns2:PV_FECHAEXPTC>{fn:data($input/CardExpirationDate)}</ns2:PV_FECHAEXPTC>
    </ns2:InputParameters>
};

local:funcPurchaseToBrokerTicket($input,$org,$sequence)