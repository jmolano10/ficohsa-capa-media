(:: pragma bea:global-element-parameter parameter="$actualizaDatosClienteIN" element="ns0:actualizaDatosCliente" location="../xsd/actualizacionDatosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/ValidaXml/xsd/ValidaXml_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaXml";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/validaXmlIN/";

				     
	
declare function xf:validaXmlIN($actualizaDatosClienteIN as element(ns0:actualizaDatosCliente),
$BancoOrigen as xs:string,
$IdServcio as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
             <ns1:PV_CODIGO_SERVICIO>{ data($IdServcio ) }</ns1:PV_CODIGO_SERVICIO>
             <ns1:PV_BANCO_ORIGEN>{ data($BancoOrigen ) }</ns1:PV_BANCO_ORIGEN>
            {
                let $FIELDS := $actualizaDatosClienteIN/CUSTOMER_FIELDS
                return
                    <ns1:PT_CAMPOS>
                    {
                       for $FIELD in $FIELDS/FIELD
                       return
                        <ns1:PT_CAMPOS_ITEM>
                                    <ns1:FIELD_NAME>{ data($FIELD/ID ) }</ns1:FIELD_NAME>
                        </ns1:PT_CAMPOS_ITEM>
                       }
                    </ns1:PT_CAMPOS>
            }
            {
                        <ns1:PT_BLOQUES>
                          { 
                            for $BLOCK in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
                               return
                            <ns1:PT_BLOQUES_ITEM>
                                        <ns1:BLOCK_TYPE>{ data($BLOCK/TYPE) }</ns1:BLOCK_TYPE>
                            </ns1:PT_BLOQUES_ITEM>
                              }
                        </ns1:PT_BLOQUES>
                      }
                
                   {
                   
                    
                    <ns1:PT_INDEX>
                           { 
                            for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
                            let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM)   
                            for $f in (1 to $contador )
                             return
                             <ns1:PT_BLOQUES_ITEM>
                                    <ns1:BLOCK_TYPE>{ data($BLOCK/TYPE) }</ns1:BLOCK_TYPE>
                                    <ns1:FIELD_NAME>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/ID) }</ns1:FIELD_NAME>
                        </ns1:PT_BLOQUES_ITEM>
                        }
                    </ns1:PT_INDEX>
            }
            {
        
                    <ns1:PT_CAMPOS_BLOQUE>
                       { 
                            for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
                            let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM)   
                            for $f in (1 to $contador )
                            let $contadorIndice:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD)
                            for $g in (1 to $contadorIndice )
                            return           
                            <ns1:PT_BLOQUES_ITEM>
                                    <ns1:BLOCK_TYPE>{ data($BLOCK/TYPE) }</ns1:BLOCK_TYPE>                     
                                    <ns1:FIELD_NAME>{ data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID) }</ns1:FIELD_NAME>
                     </ns1:PT_BLOQUES_ITEM>
                        }
                  </ns1:PT_CAMPOS_BLOQUE>
            }
        </ns1:InputParameters>
};
declare variable $BancoOrigen as xs:string external;
declare variable $IdServcio as xs:string external;
declare variable $actualizaDatosClienteIN as element(ns0:actualizaDatosCliente) external;

xf:validaXmlIN($actualizaDatosClienteIN,$BancoOrigen,$IdServcio)