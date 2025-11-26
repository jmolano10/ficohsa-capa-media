(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentaporCancelar_ValidateResponse" element="ns0:ConsultaSaldoCuentaporCancelar_ValidateResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldoCuentaPorCancelarResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuentaPorCancelar/consultaSaldoCuentaPorCancelarOut/";

declare function xf:consultaSaldoCuentaPorCancelarOut($consultaSaldoCuentaporCancelar_ValidateResponse as element(ns0:ConsultaSaldoCuentaporCancelar_ValidateResponse))
    as element(ns1:consultaSaldoCuentaPorCancelarResponse) {
        <ns1:consultaSaldoCuentaPorCancelarResponse>
            {
                for $CHARGEABLEAMT in $consultaSaldoCuentaporCancelar_ValidateResponse/ACCOUNTCLOSUREType/CHARGEABLEAMT
                return
                    <INITIAL_AMOUNT>{ data($CHARGEABLEAMT) }</INITIAL_AMOUNT>
            }
            {
                for $TOTALACCAMT in $consultaSaldoCuentaporCancelar_ValidateResponse/ACCOUNTCLOSUREType/TOTALACCAMT
                return
                    <TOTAL_AMOUNT>{ data($TOTALACCAMT) }</TOTAL_AMOUNT>
            }
            {
                for $TOTALCRINTEREST in $consultaSaldoCuentaporCancelar_ValidateResponse/ACCOUNTCLOSUREType/TOTALCRINTEREST
                return
                    <TOTAL_INTEREST>{ data($TOTALCRINTEREST) }</TOTAL_INTEREST>
            }
            {
                for $TOTALTAX in $consultaSaldoCuentaporCancelar_ValidateResponse/ACCOUNTCLOSUREType/TOTALTAX
                return
                    <TOTAL_TAX>{ data($TOTALTAX) }</TOTAL_TAX>
            }
        </ns1:consultaSaldoCuentaPorCancelarResponse>
};

declare variable $consultaSaldoCuentaporCancelar_ValidateResponse as element(ns0:ConsultaSaldoCuentaporCancelar_ValidateResponse) external;

xf:consultaSaldoCuentaPorCancelarOut($consultaSaldoCuentaporCancelar_ValidateResponse)