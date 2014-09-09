var dataString = '<chart showBorder="0" bgColor="FFFFFF,FFFFFF" palette="2" caption="" showValues="0" numVDivLines="11" drawAnchors="0" numberPrefix="" divLineAlpha="30" alternateHGridAlpha="20"  setAdaptiveYMin="1" >\n\
	<categories>\n\
        <category label="Jan" /> \n\
		<category label="Feb" /> \n\
		<category label="Mar" /> \n\
		<category label="Apr" /> \n\
		<category label="May" /> \n\
		<category label="Jun" /> \n\
		<category label="Jul" /> \n\
		<category label="Aug" /> \n\
		<category label="Sep" /> \n\
		<category label="Oct" /> \n\
		<category label="Nov" /> \n\
		<category label="Dec" /> \n\
	</categories>\n\
	<dataset seriesName="2012" color="ed7d31">\n\
		<set value="1" /> \n\
		<set value="2" /> \n\
		<set value="3" /> \n\
		<set value="5" /> \n\
		<set value="2" /> \n\
		<set value="4" /> \n\
        <set value="1" /> \n\
		<set value="2" /> \n\
		<set value="3" /> \n\
		<set value="5" /> \n\
		<set value="2" /> \n\
		<set value="4" /> \n\
	</dataset>\n\
	<dataset seriesName="2013" color="5b9bd5">\n\
		<set value="5" /> \n\
		<set value="3" /> \n\
		<set value="6" /> \n\
		<set value="2" /> \n\
		<set value="1" /> \n\
	</dataset>\n\
\n\
\n\
	<styles>\n\
		<definition>\n\
			<style name="XScaleAnim" type="ANIMATION" duration="0.5" start="0" param="_xScale" />\n\
			<style name="YScaleAnim" type="ANIMATION" duration="0.5" start="0" param="_yscale" />\n\
			<style name="XAnim" type="ANIMATION" duration="0.5" start="0" param="_yscale" />\n\
			<style name="AlphaAnim" type="ANIMATION" duration="0.5" start="0" param="_alpha" />\n\
		</definition>\n\
\n\
		<application>\n\
        		<apply toObject="CANVAS" styles="XScaleAnim, YScaleAnim,AlphaAnim" />\n\
	        	<apply toObject="DIVLINES" styles="XScaleAnim,AlphaAnim" />\n\
	        	<apply toObject="VDIVLINES" styles="YScaleAnim,AlphaAnim" />\n\
		        <apply toObject="HGRID" styles="YScaleAnim,AlphaAnim" />\n\
		</application>\n\
\n\
	</styles>\n\
</chart>';