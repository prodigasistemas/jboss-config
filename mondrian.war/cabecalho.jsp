<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.util.Properties"%>

<%
 
   
        
        InputStream stream;

        Properties propriedades = new Properties();

	String NOME_ARQUIVO_PROPRIEDADES = "/application.properties";

        
        try {

            ClassLoader classLoader = ClassLoader.getSystemClassLoader();

            stream = classLoader.getResourceAsStream(NOME_ARQUIVO_PROPRIEDADES);

	    if (stream == null) {
                stream = this.getClass().getClassLoader()
                        .getResourceAsStream(NOME_ARQUIVO_PROPRIEDADES);
            }

            if (stream == null) {
                stream = this.getClass().getResourceAsStream(NOME_ARQUIVO_PROPRIEDADES);
            }

            
            propriedades.load(stream);

        } catch (IOException e) {
            e.printStackTrace();
            System.err
                    .println("Nao foi possivel localizar o arquivo de propriedades. Certifique-se "
                            + "de que o arquivo "
                            + NOME_ARQUIVO_PROPRIEDADES
                            + " esteja na raiz do CLASSPATH");

        }

   

   
	

%>

<table width="680" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td height="0" valign="top" class="topstrip">
			<table width="100%" height="0" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="0" colspan="1" valign="bottom" class="topstrip">
						<img src="./imagens/logocompesa.gif" border="0">
					</td>

					<td width="35%" height="0" colspan="1" valign="middle" class="topstrip"
						bgcolor="#5FA7FA" align="center"><marquee bgcolor="#CBE5FE"
						title="titulo" valign="middle" loop="true" scrollamount="4"
						behavior="scroll" direction="left"><font color="black"><strong><%=propriedades.getProperty("aviso.olap")%>
					</strong></font></marquee></td>

					<td valign="bottom" align="right"><img
						src="imagens/logo_menu_superior.gif"
						border="0">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="100%" valign="top" class="centercoltext">
			<table cellpadding="1" cellspacing="1" border="0">
				<tr>
					<td align="center" width="29%"><b>Salvar Visão Relatorio:</b>
					<br><br>
						<input type="button" class="bottonRightCol" value="Salvar" onclick="window.location.href='SalvarVisao'" />
					</td>
					<td bgcolor="#FFFFFF"></td>
					<td width="13">&nbsp;</td>
					<td align="center" colspan="2"><b>Carregar Visão Relatorio:</b>
					<br>						
						<form action="restaurarVisao.jsp"
							      enctype="multipart/form-data" method="POST">
								Selecione o arquivo da visão: <input type="file" style="textbox" name="uploadVisao" size="30"><br><br><input type="submit" class="bottonRightCol" value="Visualizar Relatorio"/>
						</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>




