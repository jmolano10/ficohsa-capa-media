xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$depositoVirtualCheques" element="ns1:depositoVirtualCheques" location="../../DepositoVirtualCheques/xsd/depositoVirtualChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registrarChequePropioVirtual" location="../../../BusinessServices/SACE/WS-QUICKDEPOSIT.asmx.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoVirtualChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoChequeVirtualPropio/xq/registrarChequePropioVirtualIn/";

declare function xf:registrarChequePropioVirtualIn($depositoVirtualCheques as element(ns1:depositoVirtualCheques),
    $id as xs:string)
    as element(ns0:registrarChequePropioVirtual) {
        <ns0:registrarChequePropioVirtual>
            <ns0:CodigoRuta>{ data($depositoVirtualCheques/TRANSIT_ROUTE) }</ns0:CodigoRuta>
            <ns0:NoCheque>{ data($depositoVirtualCheques/CHEQUE_NUMBER) }</ns0:NoCheque>
            <ns0:CuentaCheque>{ data($depositoVirtualCheques/CHEQUE_ACCOUNT) }</ns0:CuentaCheque>
            <ns0:Moneda>{ data($depositoVirtualCheques/CURRENCY) }</ns0:Moneda>
            <ns0:Monto>{ data($depositoVirtualCheques/AMOUNT) }</ns0:Monto>
            <ns0:IdRefRegistroT24>{ $id }</ns0:IdRefRegistroT24>
            <ns0:CuentaDestino>{ data($depositoVirtualCheques/BEN_ACCOUNT) }</ns0:CuentaDestino>
            <ns0:ValorConfianzaA2ia/>
            <ns0:ImgAnversa>{ data($depositoVirtualCheques/FRONT_IMAGE) }</ns0:ImgAnversa>
            <ns0:ImgReversa>{ data($depositoVirtualCheques/BACK_IMAGE) }</ns0:ImgReversa>
        </ns0:registrarChequePropioVirtual>
};

declare variable $depositoVirtualCheques as element(ns1:depositoVirtualCheques) external;
declare variable $id as xs:string external;

xf:registrarChequePropioVirtualIn($depositoVirtualCheques,
    $id)