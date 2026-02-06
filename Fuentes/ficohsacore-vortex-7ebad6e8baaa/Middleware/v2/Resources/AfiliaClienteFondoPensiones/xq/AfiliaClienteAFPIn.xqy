xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$afiliaClienteFondoPensionesRequest" element="ns0:afiliaClienteFondoPensionesRequest" location="../xsd/afiliaClienteFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/AfiliaClienteAFP/xsd/AfiliaClienteAFP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/afiliaClienteFondoPensionesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AfiliaClienteAFP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliaClienteFondoPensiones/xq/AfiliaClienteAFPIn/";

declare function xf:AfiliaClienteAFPIn($afiliaClienteFondoPensionesRequest as element(ns0:afiliaClienteFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_DEUDOR>{ data($afiliaClienteFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PV_TIPO_MONEDA>{ data($afiliaClienteFondoPensionesRequest/CURRENCY) }</ns1:PV_TIPO_MONEDA>
            <ns1:PV_FECHA_INICIO>{ xs:date(data($afiliaClienteFondoPensionesRequest/START_DATE)) }</ns1:PV_FECHA_INICIO>
            <ns1:PV_FRECUENCIA>{ data($afiliaClienteFondoPensionesRequest/FREQUENCY) }</ns1:PV_FRECUENCIA>
            <ns1:TR_CUENTA_AHORRO>{ data($afiliaClienteFondoPensionesRequest/ACCOUNT) }</ns1:TR_CUENTA_AHORRO>
            <ns1:PV_DIA_COBRO>{ data($afiliaClienteFondoPensionesRequest/COLLECTION_DATE) }</ns1:PV_DIA_COBRO>
            <ns1:PN_MONTO_INDIVIDUAL>{ fn:number($afiliaClienteFondoPensionesRequest/INDIVIDUAL_AMOUNT) }</ns1:PN_MONTO_INDIVIDUAL>
            <ns1:PN_CANTIDAD_COBROS>{ fn:number($afiliaClienteFondoPensionesRequest/NUMBER_COLLECTIONS) }</ns1:PN_CANTIDAD_COBROS>
        </ns1:InputParameters>
};

declare variable $afiliaClienteFondoPensionesRequest as element(ns0:afiliaClienteFondoPensionesRequest) external;

xf:AfiliaClienteAFPIn($afiliaClienteFondoPensionesRequest)