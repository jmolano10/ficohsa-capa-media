(:: pragma bea:global-element-parameter parameter="$validaLoteBilletera" element="ns0:validaLoteBilletera" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ValidaBulk" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaLoteBilletera/xq/validaLoteBilleteraIn/";

declare function xf:validaLoteBilleteraIn($validaLoteBilletera as element(ns0:validaLoteBilletera),
    $SECURITY_KEY as xs:string,
    $SECURITY_TOKEN as xs:string)
    as element(ns1:ValidaBulk) {
        <ns1:ValidaBulk>
            <LlaveTengo>{ $SECURITY_KEY }</LlaveTengo>
            <Token>{ $SECURITY_TOKEN }</Token>
            <Usuario>{ data($validaLoteBilletera/USERNAME) }</Usuario>
            {
                let $WALLET_DETAILS := $validaLoteBilletera/WALLET_DETAILS
                return
                    <Billeteras>
                        {
                            for $WALLET in $WALLET_DETAILS/WALLET
                            return
                                <billetera>
                                    <concepto>{ data($WALLET/DESCRIPTION) }</concepto>
                                    <credBilletera>{ data($WALLET/ID) }</credBilletera>
                                    <linea>{ data($WALLET/RECORD) }</linea>
                                    <monto>{ data($WALLET/AMOUNT) }</monto>
                                    <nombreTitular>{ data($WALLET/NAME) }</nombreTitular>
                                </billetera>
                        }
                    </Billeteras>
            }
        </ns1:ValidaBulk>
};

declare variable $validaLoteBilletera as element(ns0:validaLoteBilletera) external;
declare variable $SECURITY_KEY as xs:string external;
declare variable $SECURITY_TOKEN as xs:string external;

xf:validaLoteBilleteraIn($validaLoteBilletera,
    $SECURITY_KEY,
    $SECURITY_TOKEN)
