xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatosTarjetasActivasCliente/xsd/conDatosTarjetasActivasCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTarjetasCreditoPorClienteResponse" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xq/consultaTarjetasCreditoPorClientePAOutNEW/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetasActivasCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";

declare function xf:consultaTarjetasCreditoPorClientePAOutNEW($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaTarjetasCreditoPorClienteResponse) {
        <ns1:consultaTarjetasCreditoPorClienteResponse>
            <CREDIT_CARDS>
             {
               for $row in $outputParameters1/ns0:RowSet/ns0:Row
               return
               <CREDIT_CARD_INFORMATION>
                  {
                        for $numeroTarjeta in $row/ns0:Column[@name = 'NumeroTarjeta']
                        return
                           <CREDIT_CARD_NUMBER>{ data($numeroTarjeta) }</CREDIT_CARD_NUMBER>
                  }
                  {
                        for $numeroCuenta in $row/ns0:Column[@name = 'NumeroCuenta']
                        return
                           <ACCOUNT_NUMBER>{ data($numeroCuenta) }</ACCOUNT_NUMBER>
                  }
                  {
                        for $nombreCompleto in $row/ns0:Column[@name = 'NombreCompleto']
                        return
                           <CARD_HOLDER_NAME>{ data($nombreCompleto) }</CARD_HOLDER_NAME>
                  }
                  {
                        for $categoriaTarjeta in $row/ns0:Column[@name = 'CategoriaTarjeta']
                        return
                           <CARD_TYPE>{ data($categoriaTarjeta) }</CARD_TYPE>
                  }
                  {
                        for $estadoTarjeta in $row/ns0:Column[@name = 'EstadoTarjeta']
                        return
                           <STATUS>{ data($estadoTarjeta) }</STATUS>
                  }
                  {
                        for $producto in $row/ns0:Column[@name = 'Producto']
                        return
                           <PRODUCT_TYPE>{ data($producto) }</PRODUCT_TYPE>
                  }
                  {
                        for $grupoAfinidad in $row/ns0:Column[@name = 'GrupoAfinidad']
                        return
                           <AFINITY_GROUP>{ data($grupoAfinidad) }</AFINITY_GROUP>
                  }
               </CREDIT_CARD_INFORMATION>
             }
            </CREDIT_CARDS>
        </ns1:consultaTarjetasCreditoPorClienteResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaTarjetasCreditoPorClientePAOutNEW($outputParameters1)