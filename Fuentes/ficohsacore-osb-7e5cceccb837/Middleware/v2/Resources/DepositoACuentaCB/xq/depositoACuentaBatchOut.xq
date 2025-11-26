(:: pragma bea:global-element-parameter parameter="$inputParameters" element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarTransaccionPendiente/xsd/registrarTransaccionPendienteCB_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoACuentaResponse" location="../xsd/depositoACuentaCBTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionPendienteCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/depositoACuentaBatchOut/";

declare function xf:depositoACuentaBatchOut($tipoDeposito as xs:string,
    $codBanco as xs:string,
    $fecha as xs:string,
    $inputParameters as element(ns0:InputParameters))
    as element(ns1:depositoACuentaResponse) {
        <ns1:depositoACuentaResponse>
            <ACCOUNT_NUMBER>{ data($inputParameters/ns0:PV_CUENTA_CREDITO) }</ACCOUNT_NUMBER>
            <CURRENCY>{ data($inputParameters/ns0:PV_MONEDA_DEBITO) }</CURRENCY>
            <DEPOSIT_ITEMS>
                <DEPOSIT_ITEM>
                    <DEPOSIT_TYPE>{ $tipoDeposito }</DEPOSIT_TYPE>
                    <AMOUNT>{ data($inputParameters/ns0:PN_MONTO) }</AMOUNT>
                    <BANK_CODE>{ $codBanco }</BANK_CODE>
                </DEPOSIT_ITEM>
            </DEPOSIT_ITEMS>
            <DATE_TIME>{ $fecha }</DATE_TIME>
        </ns1:depositoACuentaResponse>
};

declare variable $tipoDeposito as xs:string external;
declare variable $codBanco as xs:string external;
declare variable $fecha as xs:string external;
declare variable $inputParameters as element(ns0:InputParameters) external;

xf:depositoACuentaBatchOut($tipoDeposito,
    $codBanco,
    $fecha,
    $inputParameters)
