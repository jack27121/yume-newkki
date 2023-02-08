function dogfood_group() {
	text1[0] = ";Some dog-food";
	text1[1] = ";It feels... wet?";

	text2[0] = ";More dog-food";
	text2[1] = ";More dog-food";

	switch((inst_6E20383C).counter++)
	{
		case 0:
			text_box(text1);
			break;
		default:
			text_box(text2);
			break;
	}



}
