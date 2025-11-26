(:: pragma bea:global-element-parameter parameter="$consultaSaldoAnticipo1" element="ns0:consultaSaldoAnticipo" location="../xsd/consultaSaldoAnticipoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMaestraSaldoCuenta" location="../../ConsultaMaestraSaldoCuentas/xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoAnticipoCB/xq/consultaSaldoAnticipoCBIN/";

declare function xf:consultaSaldoAnticipoCBIN($consultaSaldoAnticipo1 as element(ns0:consultaSaldoAnticipo))
    as element(ns0:consultaMaestraSaldoCuenta) {
        <ns0:consultaMaestraSaldoCuenta>
            <ACCOUNT_NUMBER>{ data($consultaSaldoAnticipo1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
        </ns0:consultaMaestraSaldoCuenta>
};

declare variable $consultaSaldoAnticipo1 as element(ns0:consultaSaldoAnticipo) external;

xf:consultaSaldoAnticipoCBIN($consultaSaldoAnticipo1)