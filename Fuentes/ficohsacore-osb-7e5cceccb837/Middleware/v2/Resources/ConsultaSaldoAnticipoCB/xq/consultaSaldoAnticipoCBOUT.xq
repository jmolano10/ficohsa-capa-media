(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldoCuentaResponse1" element="ns0:consultaMaestraSaldoCuentaResponse" location="../../ConsultaMaestraSaldoCuentas/xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldoAnticipoResponse" location="../xsd/consultaSaldoAnticipoCBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentasCB/xq/consultaSaldoAnticipoCBOUT/";

declare function xf:consultaSaldoAnticipoCBOUT($consultaMaestraSaldoCuentaResponse1 as element(ns0:consultaMaestraSaldoCuentaResponse))
    as element(ns0:consultaSaldoAnticipoResponse) {
        <ns0:consultaSaldoAnticipoResponse>
            {
                for $CASH_ADVANCE in $consultaMaestraSaldoCuentaResponse1/CASH_ADVANCE
                return
                    <CASH_ADVANCE>{ $CASH_ADVANCE/@* , $CASH_ADVANCE/node() }</CASH_ADVANCE>
            }
        </ns0:consultaSaldoAnticipoResponse>
};

declare variable $consultaMaestraSaldoCuentaResponse1 as element(ns0:consultaMaestraSaldoCuentaResponse) external;

xf:consultaSaldoAnticipoCBOUT($consultaMaestraSaldoCuentaResponse1)