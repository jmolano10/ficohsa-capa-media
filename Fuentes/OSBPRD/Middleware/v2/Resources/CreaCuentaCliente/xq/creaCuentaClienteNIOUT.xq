(:: pragma bea:global-element-parameter parameter="$outputParametersIN" element="ns1:OutputParameters" location="../../../BusinessServices/Cobis/AperturaCuenta/xsd/OSB_Apertura_Cuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaCuentaClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/OSB_Apertura_Cuenta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaCuentaClienteNIOUT/";

declare function xf:creaCuentaClienteNIOUT($outputParametersIN as element(ns1:OutputParameters))
    as element(ns0:creaCuentaClienteResponse) {
        <ns0:creaCuentaClienteResponse>
             {
		            if ($outputParametersIN/ns1:o_desc_error = "SUCCESS") then (
            <ACCOUNT_INFORMATION>
                {
                    for $o_cta in $outputParametersIN/ns1:o_cta
                    return
                        <ACCOUNT_NUMBER>{ data($o_cta) }</ACCOUNT_NUMBER>
                }
               
                {
                    for $o_desc_error in $outputParametersIN/ns1:o_desc_error
                    return
                        <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
                }
                <ACCOUNT_INFORMATION>
                    <SUBSIDIARY>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Sucursal'])}</SUBSIDIARY>
                    <SUBSIDIARY_PHONE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Telefono_Sucursal'])}</SUBSIDIARY_PHONE>
                    <SUBSIDIARY_ADDRESS>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Direccion_Sucursal'])}</SUBSIDIARY_ADDRESS>
                    <DOCUMENT_TYPE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Documento'])}</DOCUMENT_TYPE>
                    <DOCUMENT_NUMBER>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='#_Documento'])}</DOCUMENT_NUMBER>
                    <PERSON_TYPE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Tipo_Persona'])}</PERSON_TYPE>
                    <PRODUCT_CODE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='ah_prod_banc'])}</PRODUCT_CODE>
                    <CURRENCY_CODE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Moneda'])}</CURRENCY_CODE>
                    <CURRENCY_DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='mo_descripcion'])}</CURRENCY_DESCRIPTION> 
                    <OFFICE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Oficina'])}</OFFICE>
                    <TYPE_RATE>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Tipo_Tasa_Int'])}</TYPE_RATE> 
                    <CURRENCY_SHORTENED>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Moneda_Simbolo'])}</CURRENCY_SHORTENED>
                    <OPENING_CITY>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Ciudad_Apertura'])}</OPENING_CITY>
                    <OPENING_YEAR>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Fecha_Apertura_yy'])}</OPENING_YEAR>
                    <OPENING_MONTH>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Fecha_Apertura_mm'])}</OPENING_MONTH>
                    <OPENING_DAY>{ data($outputParametersIN/ns1:RowSet[3]/ns1:Row[1]/ns1:Column[@name='Fecha_Apertura_dd'])}</OPENING_DAY>
                    <INFORMATION_MESSSAGES>
                       <WARNING>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='ADVERTENCIA'])}</WARNING>
                       <FOGADE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='FOGADE'])}</FOGADE>
                       <CLAIM>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RECLAMO'])}</CLAIM>
                       <RELEVANT>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RELEVANTE'])}</RELEVANT>
                       <FIRMS>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='FIRMAS'])}</FIRMS>
                    </INFORMATION_MESSSAGES>
                     <INSTITUTION_INFORMATION>
                       <ADDRESS>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='TDIRECCION'])}</ADDRESS>
                       <MAIL>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='TCORREO'])}</MAIL>
                       <EMAIL>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='TELECTRONICO'])}</EMAIL>
                       <WEB_ADDRESS>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='TINTERNET'])}</WEB_ADDRESS>
                       <PHONE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='TTELEFONO'])}</PHONE>
                    </INSTITUTION_INFORMATION>
                    <ACCOUNT_CHARGES>
                      <CHARGE_ITEM>
                         <DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='DESCRIPCION 1'])}</DESCRIPTION>
                         <VALUE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RUBRO 1'])}</VALUE>
                      </CHARGE_ITEM>
                      <CHARGE_ITEM>
                        <DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='DESCRIPCION 2'])}</DESCRIPTION>
                         <VALUE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RUBRO 2'])}</VALUE>
                      </CHARGE_ITEM>
                      <CHARGE_ITEM>
                         <DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='DESCRIPCION 3'])}</DESCRIPTION>
                         <VALUE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RUBRO 3'])}</VALUE>
                      </CHARGE_ITEM>
                      <CHARGE_ITEM>
                         <DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='DESCRIPCION 4'])}</DESCRIPTION>
                         <VALUE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RUBRO 4'])}</VALUE>
                      </CHARGE_ITEM>
                      <CHARGE_ITEM>
                         <DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='DESCRIPCION 5'])}</DESCRIPTION>
                         <VALUE>{ data($outputParametersIN/ns1:RowSet[4]/ns1:Row[1]/ns1:Column[@name='RUBRO 5'])}</VALUE>
                      </CHARGE_ITEM>
                    </ACCOUNT_CHARGES>       
                </ACCOUNT_INFORMATION>
                <CONTRACT_INFORMATION>
                      <ROLE>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='ROL'])}</ROLE>
                      <ACCOUNT_NAME>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='NOMBRE_CUENTA'])}</ACCOUNT_NAME>
                      <ACCOUNT_DESCRIPTION>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='DESCRIPCION'])}</ACCOUNT_DESCRIPTION>
                      <OFFICIAL>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='FUNCIONARIO'])}</OFFICIAL>
                      <TIPE_ADDRESS>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='TIPO DIRECCION'])}</TIPE_ADDRESS>
                      <OPENING_DATE>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='FECHA APERTURA'])}</OPENING_DATE>
                      <ACCOUNT_STATE>{ data($outputParametersIN/ns1:RowSet[5]/ns1:Row[1]/ns1:Column[@name='PRN ESTADO CTA'])}</ACCOUNT_STATE>
                </CONTRACT_INFORMATION>
                <INTERNATIONAL_ACCOUNT_NUMBER>{ data($outputParametersIN/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name='INTERNATIONAL_ACCOUNT_NUMBER'])}</INTERNATIONAL_ACCOUNT_NUMBER>
            </ACCOUNT_INFORMATION>
            )
            else(
            <ACCOUNT_INFORMATION>
              <MESSAGE_ID>-1</MESSAGE_ID>
              <SUCCESS_INDICATOR>ERROR</SUCCESS_INDICATOR>
               {
                    for $o_desc_error in $outputParametersIN/ns1:o_desc_error
                    return
               <ERROR_MESSAGE>{ data($o_desc_error) }</ERROR_MESSAGE>
                }
            </ACCOUNT_INFORMATION>
            )
            }
        </ns0:creaCuentaClienteResponse>
};

declare variable $outputParametersIN as element(ns1:OutputParameters) external;

xf:creaCuentaClienteNIOUT($outputParametersIN)