xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$aperturaDescuentoDocumentoRequest" element="ns0:aperturaDescuentoDocumentoRequest" location="../xsd/aperturaDescuentoDocumentoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/AperturaDescuentoDocumento/xsd/aperturaDescuentoDocumento_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/aperturaDescuentoDocumento";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaDescuentoDocumentoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AperturaDescuentoDocumento/xq/aperturaDescuentoDocumentoHNIn/";

declare function xf:aperturaDescuentoDocumentoHNIn($aperturaDescuentoDocumentoRequest as element(ns0:aperturaDescuentoDocumentoRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <GN_CODIGO_EMPRESA>{ data($aperturaDescuentoDocumentoRequest/COMPANY_CODE) }</GN_CODIGO_EMPRESA>
            <GN_CODIGO_AGENCIA>{ data($aperturaDescuentoDocumentoRequest/AGENCY_CODE) }</GN_CODIGO_AGENCIA>
            <GN_CODIGO_SUB_APLICACION>{ data($aperturaDescuentoDocumentoRequest/SUBAPLICATION_CODE) }</GN_CODIGO_SUB_APLICACION>
            <GN_CODIGO_CLIENTE>{ data($aperturaDescuentoDocumentoRequest/CUSTOMER_CODE) }</GN_CODIGO_CLIENTE>
            <GD_FECHA_VENCIMIENTO>{ data($aperturaDescuentoDocumentoRequest/EXPIRATION_DATE) }</GD_FECHA_VENCIMIENTO>
            <GN_VALOR_INICIAL>{ data($aperturaDescuentoDocumentoRequest/INITIAL_VALUE) }</GN_VALOR_INICIAL>
            <GV_CODIGO_APLIC_LINEA_CREDITO>{ data($aperturaDescuentoDocumentoRequest/LINE_APLICATION_CODE) }</GV_CODIGO_APLIC_LINEA_CREDITO>
            <GN_CODIGO_AGENCIA_LC>{ data($aperturaDescuentoDocumentoRequest/LINE_AGENCY_CODE) }</GN_CODIGO_AGENCIA_LC>
            <GN_CODIGO_SUBAPLIC_LINEA>{ data($aperturaDescuentoDocumentoRequest/LINE_SUBAPLICATION_CODE) }</GN_CODIGO_SUBAPLIC_LINEA>
            <GN_NUMERO_LINEA_CREDITO>{ data($aperturaDescuentoDocumentoRequest/LINE_CREDIT_NUMBER) }</GN_NUMERO_LINEA_CREDITO>
            <GN_TASA_DE_CAMBIO>{ data($aperturaDescuentoDocumentoRequest/EXCHANGE_RATE) }</GN_TASA_DE_CAMBIO>
            <GN_TASA_BASE>{ data($aperturaDescuentoDocumentoRequest/BASE_RATE) }</GN_TASA_BASE>
            <GN_VALOR_ORIGINAL>{ data($aperturaDescuentoDocumentoRequest/ORIGINAL_VALUE) }</GN_VALOR_ORIGINAL>
            <GN_TASA_TOTAL>{ data($aperturaDescuentoDocumentoRequest/TOTAL_RATE) }</GN_TASA_TOTAL>
            <GN_SPREAD_TASA>{ data($aperturaDescuentoDocumentoRequest/SPREAD_RATE) }</GN_SPREAD_TASA>
            <GV_RELACION_MATEMATICA_1>{ data($aperturaDescuentoDocumentoRequest/MATH_RELATION_1) }</GV_RELACION_MATEMATICA_1>
            <GN_PORCENTAJE_INTERES_MORA>{ data($aperturaDescuentoDocumentoRequest/DELAY_INTEREST_PERCENTAGE) }</GN_PORCENTAJE_INTERES_MORA>
            <GN_SPREAD_MORA>{ data($aperturaDescuentoDocumentoRequest/SPREAD_DELAY) }</GN_SPREAD_MORA>
            <GV_RELACION_MATEMATICA_2>{ data($aperturaDescuentoDocumentoRequest/MATH_RELATION_2) }</GV_RELACION_MATEMATICA_2>
            <GN_TASA_BASE_MORA>{ data($aperturaDescuentoDocumentoRequest/DELAY_BASE_RATE) }</GN_TASA_BASE_MORA>
            <GV_DEBITO_AUTOMATICO>{ data($aperturaDescuentoDocumentoRequest/AUTOMATIC_DEBIT) }</GV_DEBITO_AUTOMATICO>
            <GV_CODIGO_USUARIO>{ data($aperturaDescuentoDocumentoRequest/USER_CODE) }</GV_CODIGO_USUARIO>
            <GN_NUMERO_DOCUMENTO>{ data($aperturaDescuentoDocumentoRequest/DOCUMENT_NUMBER) }</GN_NUMERO_DOCUMENTO>
            <GN_NUMERO_DE_CUOTA>{ data($aperturaDescuentoDocumentoRequest/QUOTA_NUMBER) }</GN_NUMERO_DE_CUOTA>
            <GD_FECHA_DE_PAGO>{ data($aperturaDescuentoDocumentoRequest/PAYMENT_DATE) }</GD_FECHA_DE_PAGO>
            <GN_VALOR_DOCUMENTO>{ data($aperturaDescuentoDocumentoRequest/DOCUMENT_VALUE) }</GN_VALOR_DOCUMENTO>
            <GN_CODIGO_AGENCIA_CUENTA>{ data($aperturaDescuentoDocumentoRequest/ACCOUNT_AGENCY_CODE) }</GN_CODIGO_AGENCIA_CUENTA>
            <GV_APLICACION_CUENTA>{ data($aperturaDescuentoDocumentoRequest/APLICATION_ACCOUNT) }</GV_APLICACION_CUENTA>
            <GN_CODIGO_SUBAPLICACION_CUENTA>{ data($aperturaDescuentoDocumentoRequest/ACCOUNT_SUBAPLICATION_CODE) }</GN_CODIGO_SUBAPLICACION_CUENTA>
            <GN_CODIGO_CUENTA>{ data($aperturaDescuentoDocumentoRequest/ACCOUNT_CODE) }</GN_CODIGO_CUENTA>
            <GN_TIPO_INVERSION>{ data($aperturaDescuentoDocumentoRequest/INVESTMENT_TYPE) }</GN_TIPO_INVERSION>
            <GN_CODIGO_DESTINO>{ data($aperturaDescuentoDocumentoRequest/DESTINATION_CODE) }</GN_CODIGO_DESTINO>
            <GN_NUMERO_GARANTIA>{ data($aperturaDescuentoDocumentoRequest/ASSURANCE_NUMBER) }</GN_NUMERO_GARANTIA>
            <GN_CODIGO_DEUDOR>{ data($aperturaDescuentoDocumentoRequest/DEBTOR_CODE) }</GN_CODIGO_DEUDOR>
            <GV_CATEGORIA_RAS>{ data($aperturaDescuentoDocumentoRequest/RAS_CATEGORY) }</GV_CATEGORIA_RAS>
            <GV_CODIGO_DEPARTAMENTO>{ data($aperturaDescuentoDocumentoRequest/DEPARTAMENT_CODE) }</GV_CODIGO_DEPARTAMENTO>
            <GV_CODIGO_MUNICIPIO>{ data($aperturaDescuentoDocumentoRequest/TOWN_CODE) }</GV_CODIGO_MUNICIPIO>
            <GV_CODIGO_ALDEA>{ data($aperturaDescuentoDocumentoRequest/VILLAGE_CODE) }</GV_CODIGO_ALDEA>
        </ns1:InputParameters>
};

declare variable $aperturaDescuentoDocumentoRequest as element(ns0:aperturaDescuentoDocumentoRequest) external;

xf:aperturaDescuentoDocumentoHNIn($aperturaDescuentoDocumentoRequest)