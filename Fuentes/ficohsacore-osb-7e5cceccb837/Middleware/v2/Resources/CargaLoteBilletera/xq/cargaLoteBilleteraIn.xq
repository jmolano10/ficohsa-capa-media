(:: pragma bea:global-element-parameter parameter="$cargaLoteBilletera" element="ns0:cargaLoteBilletera" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoTranfer" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaLoteBilletera/xq/cargaLoteBilleteraIn/";

declare function xf:cargaLoteBilleteraIn($cargaLoteBilletera as element(ns0:cargaLoteBilletera),
    $SECURITY_KEY as xs:string,
    $SECURITY_TOKEN as xs:string)
    as element(ns1:PagoTranfer) {
        <ns1:PagoTranfer>
            <LlaveTengo>{ $SECURITY_KEY }</LlaveTengo>
            <Token>{ $SECURITY_TOKEN }</Token>
            <Usuario>{ data($cargaLoteBilletera/USERNAME) }</Usuario>
            <debBilletera>{ data($cargaLoteBilletera/DEBIT_WALLET) }</debBilletera>
            <Pass>{ data($cargaLoteBilletera/PASSWORD) }</Pass>
            {
                let $WALLET_DETAILS := $cargaLoteBilletera/WALLET_DETAILS
                return
                    <Billeteras>
                        {
                            for $WALLET in $WALLET_DETAILS/WALLET
                            return
                                <billetera>
                                    <credBilletera>{ data($WALLET/ID) }</credBilletera>
                                    <identidad>{ data($WALLET/LEGAL_ID) }</identidad>
                                    <linea>{ data($WALLET/RECORD) }</linea>
                                    <monto>{ data($WALLET/AMOUNT) }</monto>
                                    <nombreTitular>{ data($WALLET/NAME) }</nombreTitular>
                                    <tipoProducto>{ data($WALLET/PRODUCT_TYPE) }</tipoProducto>
                                </billetera>
                        }
                    </Billeteras>
            }
            <Correlativo>{ data($cargaLoteBilletera/BANK_BATCH_ID) }</Correlativo>
            <Descripcion>{ data($cargaLoteBilletera/BATCH_DESCRIPTION) }</Descripcion>
            <SMSPush>{ data($cargaLoteBilletera/MESSAGE) }</SMSPush>
        </ns1:PagoTranfer>
};

declare variable $cargaLoteBilletera as element(ns0:cargaLoteBilletera) external;
declare variable $SECURITY_KEY as xs:string external;
declare variable $SECURITY_TOKEN as xs:string external;

xf:cargaLoteBilleteraIn($cargaLoteBilletera,
    $SECURITY_KEY,
    $SECURITY_TOKEN)
