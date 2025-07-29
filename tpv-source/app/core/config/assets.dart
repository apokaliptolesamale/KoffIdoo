// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, camel_case_types
 import 'dart:io';
 import 'package:path_provider/path_provider.dart';
 import 'package:flutter/services.dart' show rootBundle;
 abstract class AssetsNameSpace {
		 String getPath() {
			return toString();
		}
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName");
 }
 
class AssetsCcsImpl implements AssetsNameSpace {
 
	final String path='assets/ccs';
 
	final Assets customLoginCss = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS;
 
	AssetsCcsImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsFontsImpl implements AssetsNameSpace {
 
	final String path='assets/fonts';
 
	final Assets customLoginCss = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS;
 
	final Assets PacificoRegularTtf = Assets.ASSETS_FONTS_PACIFICO_REGULAR_TTF;
 
	final Assets RobotoBoldTtf = Assets.ASSETS_FONTS_ROBOTO_BOLD_TTF;
 
	final Assets RobotoMediumTtf = Assets.ASSETS_FONTS_ROBOTO_MEDIUM_TTF;
 
	final Assets RobotoRegularTtf = Assets.ASSETS_FONTS_ROBOTO_REGULAR_TTF;
 
	final Assets SourceSansProRegularTtf = Assets.ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF;
 
	AssetsFontsImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesImpl implements AssetsNameSpace {
 
	final String path='assets/images';
 
	final Assets customLoginCss = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS;
 
	final Assets PacificoRegularTtf = Assets.ASSETS_FONTS_PACIFICO_REGULAR_TTF;
 
	final Assets RobotoBoldTtf = Assets.ASSETS_FONTS_ROBOTO_BOLD_TTF;
 
	final Assets RobotoMediumTtf = Assets.ASSETS_FONTS_ROBOTO_MEDIUM_TTF;
 
	final Assets RobotoRegularTtf = Assets.ASSETS_FONTS_ROBOTO_REGULAR_TTF;
 
	final Assets SourceSansProRegularTtf = Assets.ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF;
 
	AssetsImagesImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}

class AssetsImagesBackgroundsImpl implements AssetsNameSpace {
 
	final String path='assets/images/backgrounds';
 
	final Assets back1Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK1_PNG;
 
	final Assets back2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK2_PNG;
 
	final Assets back3Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK3_PNG;
 
	final Assets defaultJpg = Assets.ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG;
 
	AssetsImagesBackgroundsImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}

class AssetsImagesBackgroundsEnzonaImpl implements AssetsNameSpace {
 
	final String path='assets/images/backgrounds/enzona';
 
	final Assets fondoInicioPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_PNG;
 
	final Assets actualizarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ACTUALIZAR_PNG;
 
	final Assets ayudaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_AYUDA_PNG;
 
	final Assets back1Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK1_PNG;
 
	final Assets back2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK2_PNG;
 
	final Assets back3Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK3_PNG;
 
	final Assets cerrarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CERRAR_PNG;
 
	final Assets codigoQrPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CODIGO_QR_PNG;
 
	final Assets configuracionPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_PNG;
 
	final Assets configuracionDePagoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_DE_PAGO_PNG;
 
	final Assets confirPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIR_PNG;
 
	final Assets contactenosPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTACTENOS_PNG;
 
	final Assets contrasenaDePagoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTRASENA_DE_PAGO_PNG;
 
	final Assets correoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CORREO_PNG;
 
	final Assets cuentaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CUENTA_PNG;
 
	final Assets direccionPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_DIRECCION_PNG;
 
	final Assets eliminarContrasennaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ELIMINAR_CONTRASENNA_PNG;
 
	final Assets escanearTransparentePng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ESCANEAR_TRANSPARENTE_PNG;
 
	final Assets ezPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_EZ_PNG;
 
	final Assets fechaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FECHA_PNG;
 
	final Assets fondoDonar2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_DONAR2_PNG;
 
	final Assets fondoInicio2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_2_PNG;
 
	final Assets fondoPagarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_PAGAR_PNG;
 
	final Assets fondoYoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_YO_PNG;
 
	final Assets huellaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_HUELLA_PNG;
 
	final Assets iconoEzPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ_PNG;
 
	final Assets iconoEz2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ2_PNG;
 
	final Assets icBandecXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BANDEC_XML;
 
	final Assets icBicsaXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BICSA_XML;
 
	final Assets icBmSvg = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_SVG;
 
	final Assets icBmXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_XML;
 
	final Assets icBpaSvg = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_SVG;
 
	final Assets icBpaXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_XML;
 
	final Assets icNominaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_PNG;
 
	final Assets icNominaVerdePng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_VERDE_PNG;
 
	final Assets imFotoTarjetaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_TARJETA_PNG;
 
	final Assets imFotoUsuarioCopyPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_COPY_PNG;
 
	final Assets imFotoUsuarioPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG;
 
	final Assets jarLoadingGif = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_JAR_LOADING_GIF;
 
	final Assets logoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_PNG;
 
	final Assets logoXetidPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_XETID_PNG;
 
	final Assets misFacturasPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_MIS_FACTURAS_PNG;
 
	final Assets pagarFacturaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_PAGAR_FACTURA_PNG;
 
	final Assets postalesPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_POSTALES_PNG;
 
	final Assets qrPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_QR_PNG;
 
	final Assets seguridadPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEGURIDAD_PNG;
 
	final Assets sexoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEXO_PNG;
 
	final Assets sinInternetPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SIN_INTERNET_PNG;
 
	final Assets tarjetaAzulPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TARJETA_AZUL_PNG;
 
	final Assets telefonoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TELEFONO_PNG;
 
	final Assets transaccionesPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSACCIONES_PNG;
 
	final Assets transferirAmigoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_AMIGO_PNG;
 
	final Assets transferirTarjetaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_TARJETA_PNG;
 
	final Assets verificarIdentidadPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_VERIFICAR_IDENTIDAD_PNG;
 
	AssetsImagesBackgroundsEnzonaImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesBackgroundsTpvImpl implements AssetsNameSpace {
 
	final String path='assets/images/backgrounds/tpv';
 
	final Assets fondoInicioPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_PNG;
 
	final Assets actualizarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ACTUALIZAR_PNG;
 
	final Assets ayudaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_AYUDA_PNG;
 
	final Assets back1Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK1_PNG;
 
	final Assets back2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK2_PNG;
 
	final Assets back3Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK3_PNG;
 
	final Assets cerrarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CERRAR_PNG;
 
	final Assets codigoQrPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CODIGO_QR_PNG;
 
	final Assets configuracionPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_PNG;
 
	final Assets configuracionDePagoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_DE_PAGO_PNG;
 
	final Assets confirPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIR_PNG;
 
	final Assets contactenosPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTACTENOS_PNG;
 
	final Assets contrasenaDePagoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTRASENA_DE_PAGO_PNG;
 
	final Assets correoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CORREO_PNG;
 
	final Assets cuentaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CUENTA_PNG;
 
	final Assets direccionPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_DIRECCION_PNG;
 
	final Assets eliminarContrasennaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ELIMINAR_CONTRASENNA_PNG;
 
	final Assets escanearTransparentePng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ESCANEAR_TRANSPARENTE_PNG;
 
	final Assets ezPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_EZ_PNG;
 
	final Assets fechaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FECHA_PNG;
 
	final Assets fondoDonar2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_DONAR2_PNG;
 
	final Assets fondoInicio2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_2_PNG;
 
	final Assets fondoPagarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_PAGAR_PNG;
 
	final Assets fondoYoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_YO_PNG;
 
	final Assets huellaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_HUELLA_PNG;
 
	final Assets iconoEzPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ_PNG;
 
	final Assets iconoEz2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ2_PNG;
 
	final Assets icBandecXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BANDEC_XML;
 
	final Assets icBicsaXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BICSA_XML;
 
	final Assets icBmSvg = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_SVG;
 
	final Assets icBmXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_XML;
 
	final Assets icBpaSvg = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_SVG;
 
	final Assets icBpaXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_XML;
 
	final Assets icNominaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_PNG;
 
	final Assets icNominaVerdePng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_VERDE_PNG;
 
	final Assets imFotoTarjetaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_TARJETA_PNG;
 
	final Assets imFotoUsuarioCopyPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_COPY_PNG;
 
	final Assets imFotoUsuarioPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG;
 
	final Assets jarLoadingGif = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_JAR_LOADING_GIF;
 
	final Assets logoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_PNG;
 
	final Assets logoXetidPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_XETID_PNG;
 
	final Assets misFacturasPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_MIS_FACTURAS_PNG;
 
	final Assets pagarFacturaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_PAGAR_FACTURA_PNG;
 
	final Assets postalesPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_POSTALES_PNG;
 
	final Assets qrPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_QR_PNG;
 
	final Assets seguridadPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEGURIDAD_PNG;
 
	final Assets sexoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEXO_PNG;
 
	final Assets sinInternetPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SIN_INTERNET_PNG;
 
	final Assets tarjetaAzulPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TARJETA_AZUL_PNG;
 
	final Assets telefonoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TELEFONO_PNG;
 
	final Assets transaccionesPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSACCIONES_PNG;
 
	final Assets transferirAmigoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_AMIGO_PNG;
 
	final Assets transferirTarjetaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_TARJETA_PNG;
 
	final Assets verificarIdentidadPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_VERIFICAR_IDENTIDAD_PNG;
 
	final Assets tpvDefaultJpg = Assets.ASSETS_IMAGES_BACKGROUNDS_TPV_TPV_DEFAULT_JPG;
 
	AssetsImagesBackgroundsTpvImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesBackgroundsWarrantyImpl implements AssetsNameSpace {
 
	final String path='assets/images/backgrounds/warranty';
 
	final Assets fondoInicioPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_PNG;
 
	final Assets actualizarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ACTUALIZAR_PNG;
 
	final Assets ayudaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_AYUDA_PNG;
 
	final Assets back1Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK1_PNG;
 
	final Assets back2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK2_PNG;
 
	final Assets back3Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK3_PNG;
 
	final Assets cerrarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CERRAR_PNG;
 
	final Assets codigoQrPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CODIGO_QR_PNG;
 
	final Assets configuracionPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_PNG;
 
	final Assets configuracionDePagoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_DE_PAGO_PNG;
 
	final Assets confirPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIR_PNG;
 
	final Assets contactenosPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTACTENOS_PNG;
 
	final Assets contrasenaDePagoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTRASENA_DE_PAGO_PNG;
 
	final Assets correoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CORREO_PNG;
 
	final Assets cuentaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CUENTA_PNG;
 
	final Assets direccionPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_DIRECCION_PNG;
 
	final Assets eliminarContrasennaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ELIMINAR_CONTRASENNA_PNG;
 
	final Assets escanearTransparentePng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ESCANEAR_TRANSPARENTE_PNG;
 
	final Assets ezPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_EZ_PNG;
 
	final Assets fechaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FECHA_PNG;
 
	final Assets fondoDonar2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_DONAR2_PNG;
 
	final Assets fondoInicio2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_2_PNG;
 
	final Assets fondoPagarPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_PAGAR_PNG;
 
	final Assets fondoYoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_YO_PNG;
 
	final Assets huellaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_HUELLA_PNG;
 
	final Assets iconoEzPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ_PNG;
 
	final Assets iconoEz2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ2_PNG;
 
	final Assets icBandecXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BANDEC_XML;
 
	final Assets icBicsaXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BICSA_XML;
 
	final Assets icBmSvg = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_SVG;
 
	final Assets icBmXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_XML;
 
	final Assets icBpaSvg = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_SVG;
 
	final Assets icBpaXml = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_XML;
 
	final Assets icNominaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_PNG;
 
	final Assets icNominaVerdePng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_VERDE_PNG;
 
	final Assets imFotoTarjetaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_TARJETA_PNG;
 
	final Assets imFotoUsuarioCopyPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_COPY_PNG;
 
	final Assets imFotoUsuarioPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG;
 
	final Assets jarLoadingGif = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_JAR_LOADING_GIF;
 
	final Assets logoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_PNG;
 
	final Assets logoXetidPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_XETID_PNG;
 
	final Assets misFacturasPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_MIS_FACTURAS_PNG;
 
	final Assets pagarFacturaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_PAGAR_FACTURA_PNG;
 
	final Assets postalesPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_POSTALES_PNG;
 
	final Assets qrPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_QR_PNG;
 
	final Assets seguridadPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEGURIDAD_PNG;
 
	final Assets sexoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEXO_PNG;
 
	final Assets sinInternetPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SIN_INTERNET_PNG;
 
	final Assets tarjetaAzulPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TARJETA_AZUL_PNG;
 
	final Assets telefonoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TELEFONO_PNG;
 
	final Assets transaccionesPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSACCIONES_PNG;
 
	final Assets transferirAmigoPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_AMIGO_PNG;
 
	final Assets transferirTarjetaPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_TARJETA_PNG;
 
	final Assets verificarIdentidadPng = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_VERIFICAR_IDENTIDAD_PNG;
 
	final Assets tpvDefaultJpg = Assets.ASSETS_IMAGES_BACKGROUNDS_TPV_TPV_DEFAULT_JPG;
 
	final Assets defaultJpg = Assets.ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG;
 
	AssetsImagesBackgroundsWarrantyImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesIconsImpl implements AssetsNameSpace {
 
	final String path='assets/images/icons';
 
	final Assets back1Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK1_PNG;
 
	final Assets back2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK2_PNG;
 
	final Assets back3Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK3_PNG;
 
	final Assets defaultJpg = Assets.ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG;
 
	AssetsImagesIconsImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}

class AssetsImagesIconsAppImpl implements AssetsNameSpace {
 
	final String path='assets/images/icons/app';
 
	final Assets carritoPng = Assets.ASSETS_IMAGES_ICONS_APP_CARRITO_PNG;
 
	final Assets cuentaPng = Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG;
 
	final Assets emptyimgJpeg = Assets.ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG;
 
	final Assets escanerAmigoPng = Assets.ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG;
 
	final Assets icProductoPng = Assets.ASSETS_IMAGES_ICONS_APP_IC_PRODUCTO_PNG;
 
	final Assets sinNadaPng = Assets.ASSETS_IMAGES_ICONS_APP_SIN_NADA_PNG;
 
	final Assets userAdminPng = Assets.ASSETS_IMAGES_ICONS_APP_USER_ADMIN_PNG;
 
	AssetsImagesIconsAppImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}

class AssetsImagesIconsAppEnzonaImpl implements AssetsNameSpace {
 
	final String path='assets/images/icons/app/enzona';
 
	final Assets fotocomercioPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FOTOCOMERCIO_PNG;
 
	final Assets correoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CORREO_PNG;
 
	final Assets cupetPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CUPET_PNG;
 
	final Assets donarPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_DONAR_PNG;
 
	final Assets efectivoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EFECTIVO_PNG;
 
	final Assets etecsaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ETECSA_PNG;
 
	final Assets ezDefaultPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EZ_DEFAULT_PNG;
 
	final Assets facturaAutoElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_AUTO_ELECT_PNG;
 
	final Assets facturaConfCorreoElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CORREO_ELECT_PNG;
 
	final Assets facturaConfCupetElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CUPET_ELECT_PNG;
 
	final Assets facturaConfElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ELECT_PNG;
 
	final Assets facturaConfEtecsaElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ETECSA_ELECT_PNG;
 
	final Assets facturaMensualCorreoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CORREO_PNG;
 
	final Assets facturaMensualCupetPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CUPET_PNG;
 
	final Assets facturaMensualElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ELECT_PNG;
 
	final Assets facturaMensualEtecsaElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ETECSA_ELECT_PNG;
 
	final Assets facturaMensualOnatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ONAT_PNG;
 
	final Assets facturConfOnatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTUR_CONF_ONAT_PNG;
 
	final Assets icExtraccionPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_EXTRACCION_PNG;
 
	final Assets icNominaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_PNG;
 
	final Assets icNominaVerdePng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_VERDE_PNG;
 
	final Assets icPagoAguaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_AGUA_PNG;
 
	final Assets icPagoGasPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_GAS_PNG;
 
	final Assets icPagoTelefonoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_TELEFONO_PNG;
 
	final Assets icPosPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_POS_PNG;
 
	final Assets icTranferenciaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_TRANFERENCIA_PNG;
 
	final Assets onatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ONAT_PNG;
 
	final Assets operacionesPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_OPERACIONES_PNG;
 
	final Assets productosPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_PRODUCTOS_PNG;
 
	final Assets regaloPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO_PNG;
 
	final Assets regalo2Png = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO2_PNG;
 
	final Assets saldoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_SALDO_PNG;
 
	final Assets transferirPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_TRANSFERIR_PNG;
 
	final Assets unePng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_UNE_PNG;
 
	AssetsImagesIconsAppEnzonaImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesIconsAppTpvImpl implements AssetsNameSpace {
 
	final String path='assets/images/icons/app/tpv';
 
	final Assets fotocomercioPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FOTOCOMERCIO_PNG;
 
	final Assets correoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CORREO_PNG;
 
	final Assets cupetPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CUPET_PNG;
 
	final Assets donarPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_DONAR_PNG;
 
	final Assets efectivoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EFECTIVO_PNG;
 
	final Assets etecsaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ETECSA_PNG;
 
	final Assets ezDefaultPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EZ_DEFAULT_PNG;
 
	final Assets facturaAutoElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_AUTO_ELECT_PNG;
 
	final Assets facturaConfCorreoElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CORREO_ELECT_PNG;
 
	final Assets facturaConfCupetElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CUPET_ELECT_PNG;
 
	final Assets facturaConfElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ELECT_PNG;
 
	final Assets facturaConfEtecsaElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ETECSA_ELECT_PNG;
 
	final Assets facturaMensualCorreoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CORREO_PNG;
 
	final Assets facturaMensualCupetPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CUPET_PNG;
 
	final Assets facturaMensualElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ELECT_PNG;
 
	final Assets facturaMensualEtecsaElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ETECSA_ELECT_PNG;
 
	final Assets facturaMensualOnatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ONAT_PNG;
 
	final Assets facturConfOnatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTUR_CONF_ONAT_PNG;
 
	final Assets icExtraccionPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_EXTRACCION_PNG;
 
	final Assets icNominaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_PNG;
 
	final Assets icNominaVerdePng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_VERDE_PNG;
 
	final Assets icPagoAguaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_AGUA_PNG;
 
	final Assets icPagoGasPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_GAS_PNG;
 
	final Assets icPagoTelefonoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_TELEFONO_PNG;
 
	final Assets icPosPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_POS_PNG;
 
	final Assets icTranferenciaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_TRANFERENCIA_PNG;
 
	final Assets onatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ONAT_PNG;
 
	final Assets operacionesPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_OPERACIONES_PNG;
 
	final Assets productosPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_PRODUCTOS_PNG;
 
	final Assets regaloPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO_PNG;
 
	final Assets regalo2Png = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO2_PNG;
 
	final Assets saldoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_SALDO_PNG;
 
	final Assets transferirPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_TRANSFERIR_PNG;
 
	final Assets unePng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_UNE_PNG;
 
	final Assets tpvDefaultPng = Assets.ASSETS_IMAGES_ICONS_APP_TPV_TPV_DEFAULT_PNG;
 
	AssetsImagesIconsAppTpvImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesIconsAppWarrantyImpl implements AssetsNameSpace {
 
	final String path='assets/images/icons/app/warranty';
 
	final Assets fotocomercioPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FOTOCOMERCIO_PNG;
 
	final Assets correoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CORREO_PNG;
 
	final Assets cupetPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CUPET_PNG;
 
	final Assets donarPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_DONAR_PNG;
 
	final Assets efectivoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EFECTIVO_PNG;
 
	final Assets etecsaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ETECSA_PNG;
 
	final Assets ezDefaultPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EZ_DEFAULT_PNG;
 
	final Assets facturaAutoElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_AUTO_ELECT_PNG;
 
	final Assets facturaConfCorreoElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CORREO_ELECT_PNG;
 
	final Assets facturaConfCupetElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CUPET_ELECT_PNG;
 
	final Assets facturaConfElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ELECT_PNG;
 
	final Assets facturaConfEtecsaElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ETECSA_ELECT_PNG;
 
	final Assets facturaMensualCorreoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CORREO_PNG;
 
	final Assets facturaMensualCupetPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CUPET_PNG;
 
	final Assets facturaMensualElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ELECT_PNG;
 
	final Assets facturaMensualEtecsaElectPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ETECSA_ELECT_PNG;
 
	final Assets facturaMensualOnatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ONAT_PNG;
 
	final Assets facturConfOnatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTUR_CONF_ONAT_PNG;
 
	final Assets icExtraccionPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_EXTRACCION_PNG;
 
	final Assets icNominaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_PNG;
 
	final Assets icNominaVerdePng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_VERDE_PNG;
 
	final Assets icPagoAguaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_AGUA_PNG;
 
	final Assets icPagoGasPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_GAS_PNG;
 
	final Assets icPagoTelefonoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_TELEFONO_PNG;
 
	final Assets icPosPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_POS_PNG;
 
	final Assets icTranferenciaPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_TRANFERENCIA_PNG;
 
	final Assets onatPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ONAT_PNG;
 
	final Assets operacionesPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_OPERACIONES_PNG;
 
	final Assets productosPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_PRODUCTOS_PNG;
 
	final Assets regaloPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO_PNG;
 
	final Assets regalo2Png = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO2_PNG;
 
	final Assets saldoPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_SALDO_PNG;
 
	final Assets transferirPng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_TRANSFERIR_PNG;
 
	final Assets unePng = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_UNE_PNG;
 
	final Assets tpvDefaultPng = Assets.ASSETS_IMAGES_ICONS_APP_TPV_TPV_DEFAULT_PNG;
 
	final Assets garantiaJpeg = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_GARANTIA_JPEG;
 
	final Assets pedidosPng = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_PEDIDOS_PNG;
 
	final Assets transportePng = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_TRANSPORTE_PNG;
 
	final Assets userAdmin1Png = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN1_PNG;
 
	final Assets userAdmin2Png = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN2_PNG;
 
	final Assets userAdmin3Png = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN3_PNG;
 
	final Assets warrantyBlueJpeg = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_BLUE_JPEG;
 
	final Assets warrantyCertPng = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_CERT_PNG;
 
	final Assets warrantyIconBluePng = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_BLUE_PNG;
 
	final Assets warrantyIconPng = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_PNG;
 
	final Assets warrantyPngJpeg = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_PNG_JPEG;
 
	AssetsImagesIconsAppWarrantyImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesLogosImpl implements AssetsNameSpace {
 
	final String path='assets/images/logos';
 
	final Assets back1Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK1_PNG;
 
	final Assets back2Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK2_PNG;
 
	final Assets back3Png = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK3_PNG;
 
	final Assets defaultJpg = Assets.ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG;
 
	final Assets logoPng = Assets.ASSETS_IMAGES_LOGOS_LOGO_PNG;
 
	final Assets warrantyLogoPng = Assets.ASSETS_IMAGES_LOGOS_WARRANTY_LOGO_PNG;
 
	AssetsImagesLogosImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}

class AssetsImagesLogosEnzonaImpl implements AssetsNameSpace {
 
	final String path='assets/images/logos/enzona';
 
	final Assets ezLogoPng = Assets.ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG;
 
	AssetsImagesLogosEnzonaImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesLogosTpvImpl implements AssetsNameSpace {
 
	final String path='assets/images/logos/tpv';
 
	final Assets ezLogoPng = Assets.ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG;
 
	final Assets tpvLogoPng = Assets.ASSETS_IMAGES_LOGOS_TPV_TPV_LOGO_PNG;
 
	AssetsImagesLogosTpvImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsImagesLogosWarrantyImpl implements AssetsNameSpace {
 
	final String path='assets/images/logos/warranty';
 
	final Assets ezLogoPng = Assets.ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG;
 
	final Assets tpvLogoPng = Assets.ASSETS_IMAGES_LOGOS_TPV_TPV_LOGO_PNG;
 
	final Assets warrantyLogoPng = Assets.ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG;
 
	AssetsImagesLogosWarrantyImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsModelsImpl implements AssetsNameSpace {
 
	final String path='assets/models';
 
	final Assets customLoginCss = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS;
 
	final Assets PacificoRegularTtf = Assets.ASSETS_FONTS_PACIFICO_REGULAR_TTF;
 
	final Assets RobotoBoldTtf = Assets.ASSETS_FONTS_ROBOTO_BOLD_TTF;
 
	final Assets RobotoMediumTtf = Assets.ASSETS_FONTS_ROBOTO_MEDIUM_TTF;
 
	final Assets RobotoRegularTtf = Assets.ASSETS_FONTS_ROBOTO_REGULAR_TTF;
 
	final Assets SourceSansProRegularTtf = Assets.ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF;
 
	final Assets cardsJson = Assets.ASSETS_MODELS_CARDS_JSON;
 
	final Assets casesJson = Assets.ASSETS_MODELS_CASES_JSON;
 
	final Assets configJson = Assets.ASSETS_MODELS_CONFIG_JSON;
 
	final Assets currencyJson = Assets.ASSETS_MODELS_CURRENCY_JSON;
 
	final Assets designJson = Assets.ASSETS_MODELS_DESIGN_JSON;
 
	final Assets historyJson = Assets.ASSETS_MODELS_HISTORY_JSON;
 
	final Assets ordersJson = Assets.ASSETS_MODELS_ORDERS_JSON;
 
	final Assets paymentTypesJson = Assets.ASSETS_MODELS_PAYMENTTYPES_JSON;
 
	final Assets productsJson = Assets.ASSETS_MODELS_PRODUCTS_JSON;
 
	final Assets projectJson = Assets.ASSETS_MODELS_PROJECT_JSON;
 
	final Assets provinciasJson = Assets.ASSETS_MODELS_PROVINCIAS_JSON;
 
	final Assets securityJson = Assets.ASSETS_MODELS_SECURITY_JSON;
 
	final Assets tokenJson = Assets.ASSETS_MODELS_TOKEN_JSON;
 
	final Assets transactionsJson = Assets.ASSETS_MODELS_TRANSACTIONS_JSON;
 
	final Assets unidadesJson = Assets.ASSETS_MODELS_UNIDADES_JSON;
 
	final Assets usersJson = Assets.ASSETS_MODELS_USERS_JSON;
 
	final Assets warrantiesXml = Assets.ASSETS_MODELS_WARRANTIES_XML;
 
	AssetsModelsImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsRawImpl implements AssetsNameSpace {
 
	final String path='assets/raw';
 
	final Assets customLoginCss = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS;
 
	final Assets PacificoRegularTtf = Assets.ASSETS_FONTS_PACIFICO_REGULAR_TTF;
 
	final Assets RobotoBoldTtf = Assets.ASSETS_FONTS_ROBOTO_BOLD_TTF;
 
	final Assets RobotoMediumTtf = Assets.ASSETS_FONTS_ROBOTO_MEDIUM_TTF;
 
	final Assets RobotoRegularTtf = Assets.ASSETS_FONTS_ROBOTO_REGULAR_TTF;
 
	final Assets SourceSansProRegularTtf = Assets.ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF;
 
	final Assets cardsJson = Assets.ASSETS_MODELS_CARDS_JSON;
 
	final Assets casesJson = Assets.ASSETS_MODELS_CASES_JSON;
 
	final Assets configJson = Assets.ASSETS_MODELS_CONFIG_JSON;
 
	final Assets currencyJson = Assets.ASSETS_MODELS_CURRENCY_JSON;
 
	final Assets designJson = Assets.ASSETS_MODELS_DESIGN_JSON;
 
	final Assets historyJson = Assets.ASSETS_MODELS_HISTORY_JSON;
 
	final Assets ordersJson = Assets.ASSETS_MODELS_ORDERS_JSON;
 
	final Assets paymentTypesJson = Assets.ASSETS_MODELS_PAYMENTTYPES_JSON;
 
	final Assets productsJson = Assets.ASSETS_MODELS_PRODUCTS_JSON;
 
	final Assets projectJson = Assets.ASSETS_MODELS_PROJECT_JSON;
 
	final Assets provinciasJson = Assets.ASSETS_MODELS_PROVINCIAS_JSON;
 
	final Assets securityJson = Assets.ASSETS_MODELS_SECURITY_JSON;
 
	final Assets tokenJson = Assets.ASSETS_MODELS_TOKEN_JSON;
 
	final Assets transactionsJson = Assets.ASSETS_MODELS_TRANSACTIONS_JSON;
 
	final Assets unidadesJson = Assets.ASSETS_MODELS_UNIDADES_JSON;
 
	final Assets usersJson = Assets.ASSETS_MODELS_USERS_JSON;
 
	final Assets warrantiesXml = Assets.ASSETS_MODELS_WARRANTIES_XML;
 
	final Assets enzonaCrt = Assets.ASSETS_RAW_ENZONA_CRT;
 
	final Assets enzonaNetPem = Assets.ASSETS_RAW_ENZONA_NET_PEM;
 
	final Assets enzonaNetCaPem = Assets.ASSETS_RAW_ENZONA_NET_CA_PEM;
 
	final Assets enzonaNetCertP12 = Assets.ASSETS_RAW_ENZONA_NET_CERT_P12;
 
	final Assets enzonaNetClientPem = Assets.ASSETS_RAW_ENZONA_NET_CLIENT_PEM;
 
	final Assets enzonaNetCrtCrt = Assets.ASSETS_RAW_ENZONA_NET_CRT_CRT;
 
	final Assets enzonaNetCrtPem = Assets.ASSETS_RAW_ENZONA_NET_CRT_PEM;
 
	final Assets enzonaNetKeyKey = Assets.ASSETS_RAW_ENZONA_NET_KEY_KEY;
 
	final Assets pkceSh = Assets.ASSETS_RAW_PKCE_SH;
 
	final Assets prestaShopCertPem = Assets.ASSETS_RAW_PRESTASHOPCERT_PEM;
 
	final Assets privatekeyPem = Assets.ASSETS_RAW_PRIVATEKEY_PEM;
 
	final Assets publiccertPem = Assets.ASSETS_RAW_PUBLICCERT_PEM;
 
	AssetsRawImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}
 
class AssetsSoundsImpl implements AssetsNameSpace {
 
	final String path='assets/sounds';
 
	final Assets customLoginCss = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS;
 
	final Assets PacificoRegularTtf = Assets.ASSETS_FONTS_PACIFICO_REGULAR_TTF;
 
	final Assets RobotoBoldTtf = Assets.ASSETS_FONTS_ROBOTO_BOLD_TTF;
 
	final Assets RobotoMediumTtf = Assets.ASSETS_FONTS_ROBOTO_MEDIUM_TTF;
 
	final Assets RobotoRegularTtf = Assets.ASSETS_FONTS_ROBOTO_REGULAR_TTF;
 
	final Assets SourceSansProRegularTtf = Assets.ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF;
 
	final Assets cardsJson = Assets.ASSETS_MODELS_CARDS_JSON;
 
	final Assets casesJson = Assets.ASSETS_MODELS_CASES_JSON;
 
	final Assets configJson = Assets.ASSETS_MODELS_CONFIG_JSON;
 
	final Assets currencyJson = Assets.ASSETS_MODELS_CURRENCY_JSON;
 
	final Assets designJson = Assets.ASSETS_MODELS_DESIGN_JSON;
 
	final Assets historyJson = Assets.ASSETS_MODELS_HISTORY_JSON;
 
	final Assets ordersJson = Assets.ASSETS_MODELS_ORDERS_JSON;
 
	final Assets paymentTypesJson = Assets.ASSETS_MODELS_PAYMENTTYPES_JSON;
 
	final Assets productsJson = Assets.ASSETS_MODELS_PRODUCTS_JSON;
 
	final Assets projectJson = Assets.ASSETS_MODELS_PROJECT_JSON;
 
	final Assets provinciasJson = Assets.ASSETS_MODELS_PROVINCIAS_JSON;
 
	final Assets securityJson = Assets.ASSETS_MODELS_SECURITY_JSON;
 
	final Assets tokenJson = Assets.ASSETS_MODELS_TOKEN_JSON;
 
	final Assets transactionsJson = Assets.ASSETS_MODELS_TRANSACTIONS_JSON;
 
	final Assets unidadesJson = Assets.ASSETS_MODELS_UNIDADES_JSON;
 
	final Assets usersJson = Assets.ASSETS_MODELS_USERS_JSON;
 
	final Assets warrantiesXml = Assets.ASSETS_MODELS_WARRANTIES_XML;
 
	final Assets enzonaCrt = Assets.ASSETS_RAW_ENZONA_CRT;
 
	final Assets enzonaNetPem = Assets.ASSETS_RAW_ENZONA_NET_PEM;
 
	final Assets enzonaNetCaPem = Assets.ASSETS_RAW_ENZONA_NET_CA_PEM;
 
	final Assets enzonaNetCertP12 = Assets.ASSETS_RAW_ENZONA_NET_CERT_P12;
 
	final Assets enzonaNetClientPem = Assets.ASSETS_RAW_ENZONA_NET_CLIENT_PEM;
 
	final Assets enzonaNetCrtCrt = Assets.ASSETS_RAW_ENZONA_NET_CRT_CRT;
 
	final Assets enzonaNetCrtPem = Assets.ASSETS_RAW_ENZONA_NET_CRT_PEM;
 
	final Assets enzonaNetKeyKey = Assets.ASSETS_RAW_ENZONA_NET_KEY_KEY;
 
	final Assets pkceSh = Assets.ASSETS_RAW_PKCE_SH;
 
	final Assets prestaShopCertPem = Assets.ASSETS_RAW_PRESTASHOPCERT_PEM;
 
	final Assets privatekeyPem = Assets.ASSETS_RAW_PRIVATEKEY_PEM;
 
	final Assets publiccertPem = Assets.ASSETS_RAW_PUBLICCERT_PEM;
 
	final Assets playfulMp3 = Assets.ASSETS_SOUNDS_PLAYFUL_MP3;
 
	final Assets pristineMp3 = Assets.ASSETS_SOUNDS_PRISTINE_MP3;
 
	final Assets relentlessMp3 = Assets.ASSETS_SOUNDS_RELENTLESS_MP3;
 
	AssetsSoundsImpl();
 
	@override
	String getPath() => path;
	@override
	Assets getAsset(String fileName) => Assets.fromPath("${getPath()}/$fileName"); 

}

 
final String ASSETS_CCS_CUSTOM_LOGIN_CSS = Assets.ASSETS_CCS_CUSTOM_LOGIN_CSS.getPath;
 
final String ASSETS_FONTS_PACIFICO_REGULAR_TTF = Assets.ASSETS_FONTS_PACIFICO_REGULAR_TTF.getPath;
 
final String ASSETS_FONTS_ROBOTO_BOLD_TTF = Assets.ASSETS_FONTS_ROBOTO_BOLD_TTF.getPath;
 
final String ASSETS_FONTS_ROBOTO_MEDIUM_TTF = Assets.ASSETS_FONTS_ROBOTO_MEDIUM_TTF.getPath;
 
final String ASSETS_FONTS_ROBOTO_REGULAR_TTF = Assets.ASSETS_FONTS_ROBOTO_REGULAR_TTF.getPath;
 
final String ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF = Assets.ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_BACK1_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK1_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_BACK2_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK2_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_BACK3_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_BACK3_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG = Assets.ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_ACTUALIZAR_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ACTUALIZAR_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_AYUDA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_AYUDA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK1_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK1_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK2_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK2_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK3_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK3_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CERRAR_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CERRAR_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CODIGO_QR_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CODIGO_QR_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_DE_PAGO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_DE_PAGO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIR_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIR_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTACTENOS_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTACTENOS_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTRASENA_DE_PAGO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTRASENA_DE_PAGO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CORREO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CORREO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_CUENTA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_CUENTA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_DIRECCION_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_DIRECCION_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_ELIMINAR_CONTRASENNA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ELIMINAR_CONTRASENNA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_ESCANEAR_TRANSPARENTE_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ESCANEAR_TRANSPARENTE_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_EZ_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_EZ_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_FECHA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FECHA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_DONAR2_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_DONAR2_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_2_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_2_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_PAGAR_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_PAGAR_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_YO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_YO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_HUELLA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_HUELLA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ2_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ2_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BANDEC_XML = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BANDEC_XML.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BICSA_XML = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BICSA_XML.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_SVG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_SVG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_XML = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_XML.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_SVG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_SVG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_XML = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_XML.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_VERDE_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_VERDE_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_TARJETA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_TARJETA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_COPY_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_COPY_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_JAR_LOADING_GIF = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_JAR_LOADING_GIF.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_XETID_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_XETID_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_MIS_FACTURAS_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_MIS_FACTURAS_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_PAGAR_FACTURA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_PAGAR_FACTURA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_POSTALES_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_POSTALES_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_QR_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_QR_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEGURIDAD_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEGURIDAD_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEXO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEXO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_SIN_INTERNET_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_SIN_INTERNET_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_TARJETA_AZUL_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TARJETA_AZUL_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_TELEFONO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TELEFONO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSACCIONES_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSACCIONES_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_AMIGO_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_AMIGO_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_TARJETA_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_TARJETA_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_ENZONA_VERIFICAR_IDENTIDAD_PNG = Assets.ASSETS_IMAGES_BACKGROUNDS_ENZONA_VERIFICAR_IDENTIDAD_PNG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_TPV_TPV_DEFAULT_JPG = Assets.ASSETS_IMAGES_BACKGROUNDS_TPV_TPV_DEFAULT_JPG.getPath;
 
final String ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG = Assets.ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_CARRITO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_CARRITO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_CUENTA_PNG = Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG = Assets.ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FOTOCOMERCIO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FOTOCOMERCIO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_CORREO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CORREO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_CUPET_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_CUPET_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_DONAR_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_DONAR_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_EFECTIVO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EFECTIVO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_ETECSA_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ETECSA_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_EZ_DEFAULT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_EZ_DEFAULT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_AUTO_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_AUTO_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CORREO_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CORREO_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CUPET_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CUPET_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ETECSA_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ETECSA_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CORREO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CORREO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CUPET_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CUPET_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ETECSA_ELECT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ETECSA_ELECT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ONAT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ONAT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_FACTUR_CONF_ONAT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_FACTUR_CONF_ONAT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_EXTRACCION_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_EXTRACCION_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_VERDE_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_VERDE_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_AGUA_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_AGUA_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_GAS_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_GAS_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_TELEFONO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_TELEFONO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_POS_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_POS_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_IC_TRANFERENCIA_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_IC_TRANFERENCIA_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_ONAT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_ONAT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_OPERACIONES_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_OPERACIONES_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_PRODUCTOS_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_PRODUCTOS_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO2_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO2_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_SALDO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_SALDO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_TRANSFERIR_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_TRANSFERIR_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ENZONA_UNE_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ENZONA_UNE_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_IC_PRODUCTO_PNG = Assets.ASSETS_IMAGES_ICONS_APP_IC_PRODUCTO_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_SIN_NADA_PNG = Assets.ASSETS_IMAGES_ICONS_APP_SIN_NADA_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_TPV_TPV_DEFAULT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_TPV_TPV_DEFAULT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_USER_ADMIN_PNG = Assets.ASSETS_IMAGES_ICONS_APP_USER_ADMIN_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_GARANTIA_JPEG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_GARANTIA_JPEG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_PEDIDOS_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_PEDIDOS_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_TRANSPORTE_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_TRANSPORTE_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN1_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN1_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN2_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN2_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN3_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN3_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_BLUE_JPEG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_BLUE_JPEG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_CERT_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_CERT_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_BLUE_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_BLUE_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_PNG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_PNG.getPath;
 
final String ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_PNG_JPEG = Assets.ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_PNG_JPEG.getPath;
 
final String ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG = Assets.ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG.getPath;
 
final String ASSETS_IMAGES_LOGOS_LOGO_PNG = Assets.ASSETS_IMAGES_LOGOS_LOGO_PNG.getPath;
 
final String ASSETS_IMAGES_LOGOS_TPV_TPV_LOGO_PNG = Assets.ASSETS_IMAGES_LOGOS_TPV_TPV_LOGO_PNG.getPath;
 
final String ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG = Assets.ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG.getPath;
 
final String ASSETS_IMAGES_LOGOS_WARRANTY_LOGO_PNG = Assets.ASSETS_IMAGES_LOGOS_WARRANTY_LOGO_PNG.getPath;
 
final String ASSETS_MODELS_CARDS_JSON = Assets.ASSETS_MODELS_CARDS_JSON.getPath;
 
final String ASSETS_MODELS_CASES_JSON = Assets.ASSETS_MODELS_CASES_JSON.getPath;
 
final String ASSETS_MODELS_CONFIG_JSON = Assets.ASSETS_MODELS_CONFIG_JSON.getPath;
 
final String ASSETS_MODELS_CURRENCY_JSON = Assets.ASSETS_MODELS_CURRENCY_JSON.getPath;
 
final String ASSETS_MODELS_DESIGN_JSON = Assets.ASSETS_MODELS_DESIGN_JSON.getPath;
 
final String ASSETS_MODELS_HISTORY_JSON = Assets.ASSETS_MODELS_HISTORY_JSON.getPath;
 
final String ASSETS_MODELS_ORDERS_JSON = Assets.ASSETS_MODELS_ORDERS_JSON.getPath;
 
final String ASSETS_MODELS_PAYMENTTYPES_JSON = Assets.ASSETS_MODELS_PAYMENTTYPES_JSON.getPath;
 
final String ASSETS_MODELS_PRODUCTS_JSON = Assets.ASSETS_MODELS_PRODUCTS_JSON.getPath;
 
final String ASSETS_MODELS_PROJECT_JSON = Assets.ASSETS_MODELS_PROJECT_JSON.getPath;
 
final String ASSETS_MODELS_PROVINCIAS_JSON = Assets.ASSETS_MODELS_PROVINCIAS_JSON.getPath;
 
final String ASSETS_MODELS_SECURITY_JSON = Assets.ASSETS_MODELS_SECURITY_JSON.getPath;
 
final String ASSETS_MODELS_TOKEN_JSON = Assets.ASSETS_MODELS_TOKEN_JSON.getPath;
 
final String ASSETS_MODELS_TRANSACTIONS_JSON = Assets.ASSETS_MODELS_TRANSACTIONS_JSON.getPath;
 
final String ASSETS_MODELS_UNIDADES_JSON = Assets.ASSETS_MODELS_UNIDADES_JSON.getPath;
 
final String ASSETS_MODELS_USERS_JSON = Assets.ASSETS_MODELS_USERS_JSON.getPath;
 
final String ASSETS_MODELS_WARRANTIES_XML = Assets.ASSETS_MODELS_WARRANTIES_XML.getPath;
 
final String ASSETS_RAW_ENZONA_CRT = Assets.ASSETS_RAW_ENZONA_CRT.getPath;
 
final String ASSETS_RAW_ENZONA_NET_PEM = Assets.ASSETS_RAW_ENZONA_NET_PEM.getPath;
 
final String ASSETS_RAW_ENZONA_NET_CA_PEM = Assets.ASSETS_RAW_ENZONA_NET_CA_PEM.getPath;
 
final String ASSETS_RAW_ENZONA_NET_CERT_P12 = Assets.ASSETS_RAW_ENZONA_NET_CERT_P12.getPath;
 
final String ASSETS_RAW_ENZONA_NET_CLIENT_PEM = Assets.ASSETS_RAW_ENZONA_NET_CLIENT_PEM.getPath;
 
final String ASSETS_RAW_ENZONA_NET_CRT_CRT = Assets.ASSETS_RAW_ENZONA_NET_CRT_CRT.getPath;
 
final String ASSETS_RAW_ENZONA_NET_CRT_PEM = Assets.ASSETS_RAW_ENZONA_NET_CRT_PEM.getPath;
 
final String ASSETS_RAW_ENZONA_NET_KEY_KEY = Assets.ASSETS_RAW_ENZONA_NET_KEY_KEY.getPath;
 
final String ASSETS_RAW_PKCE_SH = Assets.ASSETS_RAW_PKCE_SH.getPath;
 
final String ASSETS_RAW_PRESTASHOPCERT_PEM = Assets.ASSETS_RAW_PRESTASHOPCERT_PEM.getPath;
 
final String ASSETS_RAW_PRIVATEKEY_PEM = Assets.ASSETS_RAW_PRIVATEKEY_PEM.getPath;
 
final String ASSETS_RAW_PUBLICCERT_PEM = Assets.ASSETS_RAW_PUBLICCERT_PEM.getPath;
 
final String ASSETS_SOUNDS_PLAYFUL_MP3 = Assets.ASSETS_SOUNDS_PLAYFUL_MP3.getPath;
 
final String ASSETS_SOUNDS_PRISTINE_MP3 = Assets.ASSETS_SOUNDS_PRISTINE_MP3.getPath;
 
final String ASSETS_SOUNDS_RELENTLESS_MP3 = Assets.ASSETS_SOUNDS_RELENTLESS_MP3.getPath;
 
 // Clase Assets para el tratamiento de los recursos de la App 
 class Assets {
 
static String rootBundleAssets = 'assets/';
 
static String assetsModels = 'assets/models/';
 
static String assetsFonts = 'assets/fonts/';
 
static String assetsImages = 'assets/images/';
 
static String assetsRaws = 'assets/raws/';
 final String _path;
 Assets(this._path); factory Assets.fromPath(String path) => Assets(path);
 String get getPath => _path;

 Future<String> loadAsset(String asset) async {
 return await rootBundle.loadString(_path);
 }
 Future<File> getFileFromContext() async {
 final byteData = await rootBundle.load('$_localPath/$_path');
 final file = File('${(await getTemporaryDirectory()).path}/$_path');
 await file.writeAsBytes(byteData.buffer .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
 return file;
 }
 Future<File> getFileFromAssets(String path) async {
 final byteData = await rootBundle.load(_path);
 final file = File('${(await getTemporaryDirectory()).path}/$path');
 await file.writeAsBytes(byteData.buffer .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
 return file;
 }
 String get _localPath {
 final directory = Directory.current;
 return directory.path;
 }
 
static Assets ASSETS_CCS_CUSTOM_LOGIN_CSS = Assets.fromPath('assets/ccs/custom_login.css');
 
static Assets ASSETS_FONTS_PACIFICO_REGULAR_TTF = Assets.fromPath('assets/fonts/Pacifico-Regular.ttf');
 
static Assets ASSETS_FONTS_ROBOTO_BOLD_TTF = Assets.fromPath('assets/fonts/Roboto-Bold.ttf');
 
static Assets ASSETS_FONTS_ROBOTO_MEDIUM_TTF = Assets.fromPath('assets/fonts/Roboto-Medium.ttf');
 
static Assets ASSETS_FONTS_ROBOTO_REGULAR_TTF = Assets.fromPath('assets/fonts/Roboto-Regular.ttf');
 
static Assets ASSETS_FONTS_SOURCESANSPRO_REGULAR_TTF = Assets.fromPath('assets/fonts/SourceSansPro-Regular.ttf');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_BACK1_PNG = Assets.fromPath('assets/images/backgrounds/back1.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_BACK2_PNG = Assets.fromPath('assets/images/backgrounds/back2.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_BACK3_PNG = Assets.fromPath('assets/images/backgrounds/back3.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG = Assets.fromPath('assets/images/backgrounds/default.jpg');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/fondo_inicio.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_ACTUALIZAR_PNG = Assets.fromPath('assets/images/backgrounds/enzona/actualizar.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_AYUDA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/ayuda.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK1_PNG = Assets.fromPath('assets/images/backgrounds/enzona/back1.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK2_PNG = Assets.fromPath('assets/images/backgrounds/enzona/back2.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_BACK3_PNG = Assets.fromPath('assets/images/backgrounds/enzona/back3.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CERRAR_PNG = Assets.fromPath('assets/images/backgrounds/enzona/cerrar.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CODIGO_QR_PNG = Assets.fromPath('assets/images/backgrounds/enzona/codigo_qr.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_PNG = Assets.fromPath('assets/images/backgrounds/enzona/configuracion.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIGURACION_DE_PAGO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/configuracion_de_pago.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONFIR_PNG = Assets.fromPath('assets/images/backgrounds/enzona/confir.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTACTENOS_PNG = Assets.fromPath('assets/images/backgrounds/enzona/contactenos.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CONTRASENA_DE_PAGO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/contrasena_de_pago.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CORREO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/correo.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_CUENTA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/cuenta.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_DIRECCION_PNG = Assets.fromPath('assets/images/backgrounds/enzona/direccion.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_ELIMINAR_CONTRASENNA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/eliminar_contrasenna.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_ESCANEAR_TRANSPARENTE_PNG = Assets.fromPath('assets/images/backgrounds/enzona/escanear_transparente.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_EZ_PNG = Assets.fromPath('assets/images/backgrounds/enzona/ez.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_FECHA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/fecha.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_DONAR2_PNG = Assets.fromPath('assets/images/backgrounds/enzona/fondo_donar2.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_INICIO_2_PNG = Assets.fromPath('assets/images/backgrounds/enzona/fondo_inicio_2.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_PAGAR_PNG = Assets.fromPath('assets/images/backgrounds/enzona/fondo_pagar.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_FONDO_YO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/fondo_yo.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_HUELLA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/huella.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ_PNG = Assets.fromPath('assets/images/backgrounds/enzona/icono_ez.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_ICONO_EZ2_PNG = Assets.fromPath('assets/images/backgrounds/enzona/icono_ez2.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BANDEC_XML = Assets.fromPath('assets/images/backgrounds/enzona/ic_bandec.xml');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BICSA_XML = Assets.fromPath('assets/images/backgrounds/enzona/ic_bicsa.xml');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_SVG = Assets.fromPath('assets/images/backgrounds/enzona/ic_bm.svg');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BM_XML = Assets.fromPath('assets/images/backgrounds/enzona/ic_bm.xml');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_SVG = Assets.fromPath('assets/images/backgrounds/enzona/ic_bpa.svg');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_BPA_XML = Assets.fromPath('assets/images/backgrounds/enzona/ic_bpa.xml');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/ic_nomina.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IC_NOMINA_VERDE_PNG = Assets.fromPath('assets/images/backgrounds/enzona/ic_nomina_verde.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_TARJETA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/im_foto_tarjeta.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_COPY_PNG = Assets.fromPath('assets/images/backgrounds/enzona/im_foto_usuario copy.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/im_foto_usuario.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_JAR_LOADING_GIF = Assets.fromPath('assets/images/backgrounds/enzona/jar-loading.gif');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/logo.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_LOGO_XETID_PNG = Assets.fromPath('assets/images/backgrounds/enzona/logo_xetid.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_MIS_FACTURAS_PNG = Assets.fromPath('assets/images/backgrounds/enzona/mis_facturas.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_PAGAR_FACTURA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/pagar_factura.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_POSTALES_PNG = Assets.fromPath('assets/images/backgrounds/enzona/postales.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_QR_PNG = Assets.fromPath('assets/images/backgrounds/enzona/qr.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEGURIDAD_PNG = Assets.fromPath('assets/images/backgrounds/enzona/seguridad.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_SEXO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/sexo.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_SIN_INTERNET_PNG = Assets.fromPath('assets/images/backgrounds/enzona/sin_internet.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_TARJETA_AZUL_PNG = Assets.fromPath('assets/images/backgrounds/enzona/tarjeta_azul.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_TELEFONO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/telefono.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSACCIONES_PNG = Assets.fromPath('assets/images/backgrounds/enzona/transacciones.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_AMIGO_PNG = Assets.fromPath('assets/images/backgrounds/enzona/transferir_amigo.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_TRANSFERIR_TARJETA_PNG = Assets.fromPath('assets/images/backgrounds/enzona/transferir_tarjeta.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_ENZONA_VERIFICAR_IDENTIDAD_PNG = Assets.fromPath('assets/images/backgrounds/enzona/verificar_identidad.png');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_TPV_TPV_DEFAULT_JPG = Assets.fromPath('assets/images/backgrounds/tpv/tpv_default.jpg');
 
static Assets ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG = Assets.fromPath('assets/images/backgrounds/warranty/default.jpg');
 
static Assets ASSETS_IMAGES_ICONS_APP_CARRITO_PNG = Assets.fromPath('assets/images/icons/app/carrito.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_CUENTA_PNG = Assets.fromPath('assets/images/icons/app/cuenta.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG = Assets.fromPath('assets/images/icons/app/emptyimg.jpeg');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FOTOCOMERCIO_PNG = Assets.fromPath('assets/images/icons/app/enzona/fotocomercio.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_CORREO_PNG = Assets.fromPath('assets/images/icons/app/enzona/correo.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_CUPET_PNG = Assets.fromPath('assets/images/icons/app/enzona/cupet.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_DONAR_PNG = Assets.fromPath('assets/images/icons/app/enzona/donar.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_EFECTIVO_PNG = Assets.fromPath('assets/images/icons/app/enzona/efectivo.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_ETECSA_PNG = Assets.fromPath('assets/images/icons/app/enzona/etecsa.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_EZ_DEFAULT_PNG = Assets.fromPath('assets/images/icons/app/enzona/ez_default.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_AUTO_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_auto_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CORREO_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_conf_correo_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_CUPET_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_conf_cupet_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_conf_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_CONF_ETECSA_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_conf_etecsa_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CORREO_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_mensual_correo.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_CUPET_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_mensual_cupet.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_mensual_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ETECSA_ELECT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_mensual_etecsa_elect.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTURA_MENSUAL_ONAT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factura_mensual_onat.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_FACTUR_CONF_ONAT_PNG = Assets.fromPath('assets/images/icons/app/enzona/factur_conf_onat.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_EXTRACCION_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_extraccion.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_nomina.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_NOMINA_VERDE_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_nomina_verde.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_AGUA_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_pago_agua.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_GAS_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_pago_gas.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_PAGO_TELEFONO_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_pago_telefono.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_POS_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_pos.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_IC_TRANFERENCIA_PNG = Assets.fromPath('assets/images/icons/app/enzona/ic_tranferencia.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_ONAT_PNG = Assets.fromPath('assets/images/icons/app/enzona/onat.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_OPERACIONES_PNG = Assets.fromPath('assets/images/icons/app/enzona/operaciones.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_PRODUCTOS_PNG = Assets.fromPath('assets/images/icons/app/enzona/productos.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO_PNG = Assets.fromPath('assets/images/icons/app/enzona/regalo.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_REGALO2_PNG = Assets.fromPath('assets/images/icons/app/enzona/regalo2.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_SALDO_PNG = Assets.fromPath('assets/images/icons/app/enzona/saldo.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_TRANSFERIR_PNG = Assets.fromPath('assets/images/icons/app/enzona/transferir.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ENZONA_UNE_PNG = Assets.fromPath('assets/images/icons/app/enzona/une.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG = Assets.fromPath('assets/images/icons/app/escaner_amigo.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_IC_PRODUCTO_PNG = Assets.fromPath('assets/images/icons/app/ic_producto.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_SIN_NADA_PNG = Assets.fromPath('assets/images/icons/app/sin_nada.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_TPV_TPV_DEFAULT_PNG = Assets.fromPath('assets/images/icons/app/tpv/tpv_default.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_USER_ADMIN_PNG = Assets.fromPath('assets/images/icons/app/user-admin.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_GARANTIA_JPEG = Assets.fromPath('assets/images/icons/app/warranty/garantia.jpeg');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_PEDIDOS_PNG = Assets.fromPath('assets/images/icons/app/warranty/pedidos.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_TRANSPORTE_PNG = Assets.fromPath('assets/images/icons/app/warranty/transporte.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN1_PNG = Assets.fromPath('assets/images/icons/app/warranty/user-admin1.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN2_PNG = Assets.fromPath('assets/images/icons/app/warranty/user-admin2.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_USER_ADMIN3_PNG = Assets.fromPath('assets/images/icons/app/warranty/user-admin3.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_BLUE_JPEG = Assets.fromPath('assets/images/icons/app/warranty/warranty-blue.jpeg');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_CERT_PNG = Assets.fromPath('assets/images/icons/app/warranty/warranty-cert.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_BLUE_PNG = Assets.fromPath('assets/images/icons/app/warranty/warranty-icon-blue.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_ICON_PNG = Assets.fromPath('assets/images/icons/app/warranty/warranty-icon.png');
 
static Assets ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_PNG_JPEG = Assets.fromPath('assets/images/icons/app/warranty/warranty-png.jpeg');
 
static Assets ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG = Assets.fromPath('assets/images/logos/enzona/ez_logo.png');
 
static Assets ASSETS_IMAGES_LOGOS_LOGO_PNG = Assets.fromPath('assets/images/logos/logo.png');
 
static Assets ASSETS_IMAGES_LOGOS_TPV_TPV_LOGO_PNG = Assets.fromPath('assets/images/logos/tpv/tpv_logo.png');
 
static Assets ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG = Assets.fromPath('assets/images/logos/warranty/warranty_logo.png');
 
static Assets ASSETS_IMAGES_LOGOS_WARRANTY_LOGO_PNG = Assets.fromPath('assets/images/logos/warranty_logo.png');
 
static Assets ASSETS_MODELS_CARDS_JSON = Assets.fromPath('assets/models/cards.json');
 
static Assets ASSETS_MODELS_CASES_JSON = Assets.fromPath('assets/models/cases.json');
 
static Assets ASSETS_MODELS_CONFIG_JSON = Assets.fromPath('assets/models/config.json');
 
static Assets ASSETS_MODELS_CURRENCY_JSON = Assets.fromPath('assets/models/currency.json');
 
static Assets ASSETS_MODELS_DESIGN_JSON = Assets.fromPath('assets/models/design.json');
 
static Assets ASSETS_MODELS_HISTORY_JSON = Assets.fromPath('assets/models/history.json');
 
static Assets ASSETS_MODELS_ORDERS_JSON = Assets.fromPath('assets/models/orders.json');
 
static Assets ASSETS_MODELS_PAYMENTTYPES_JSON = Assets.fromPath('assets/models/paymentTypes.json');
 
static Assets ASSETS_MODELS_PRODUCTS_JSON = Assets.fromPath('assets/models/products.json');
 
static Assets ASSETS_MODELS_PROJECT_JSON = Assets.fromPath('assets/models/project.json');
 
static Assets ASSETS_MODELS_PROVINCIAS_JSON = Assets.fromPath('assets/models/provincias.json');
 
static Assets ASSETS_MODELS_SECURITY_JSON = Assets.fromPath('assets/models/security.json');
 
static Assets ASSETS_MODELS_TOKEN_JSON = Assets.fromPath('assets/models/token.json');
 
static Assets ASSETS_MODELS_TRANSACTIONS_JSON = Assets.fromPath('assets/models/transactions.json');
 
static Assets ASSETS_MODELS_UNIDADES_JSON = Assets.fromPath('assets/models/unidades.json');
 
static Assets ASSETS_MODELS_USERS_JSON = Assets.fromPath('assets/models/users.json');
 
static Assets ASSETS_MODELS_WARRANTIES_XML = Assets.fromPath('assets/models/warranties.xml');
 
static Assets ASSETS_RAW_ENZONA_CRT = Assets.fromPath('assets/raw/enzona.crt');
 
static Assets ASSETS_RAW_ENZONA_NET_PEM = Assets.fromPath('assets/raw/enzona_net.pem');
 
static Assets ASSETS_RAW_ENZONA_NET_CA_PEM = Assets.fromPath('assets/raw/enzona_net_ca.pem');
 
static Assets ASSETS_RAW_ENZONA_NET_CERT_P12 = Assets.fromPath('assets/raw/enzona_net_cert.p12');
 
static Assets ASSETS_RAW_ENZONA_NET_CLIENT_PEM = Assets.fromPath('assets/raw/enzona_net_client.pem');
 
static Assets ASSETS_RAW_ENZONA_NET_CRT_CRT = Assets.fromPath('assets/raw/enzona_net_crt.crt');
 
static Assets ASSETS_RAW_ENZONA_NET_CRT_PEM = Assets.fromPath('assets/raw/enzona_net_crt.pem');
 
static Assets ASSETS_RAW_ENZONA_NET_KEY_KEY = Assets.fromPath('assets/raw/enzona_net_key.key');
 
static Assets ASSETS_RAW_PKCE_SH = Assets.fromPath('assets/raw/pkce.sh');
 
static Assets ASSETS_RAW_PRESTASHOPCERT_PEM = Assets.fromPath('assets/raw/prestaShopCert.pem');
 
static Assets ASSETS_RAW_PRIVATEKEY_PEM = Assets.fromPath('assets/raw/privatekey.pem');
 
static Assets ASSETS_RAW_PUBLICCERT_PEM = Assets.fromPath('assets/raw/publiccert.pem');
 
static Assets ASSETS_SOUNDS_PLAYFUL_MP3 = Assets.fromPath('assets/sounds/playful.mp3');
 
static Assets ASSETS_SOUNDS_PRISTINE_MP3 = Assets.fromPath('assets/sounds/pristine.mp3');
 
static Assets ASSETS_SOUNDS_RELENTLESS_MP3 = Assets.fromPath('assets/sounds/relentless.mp3');
 
 }
