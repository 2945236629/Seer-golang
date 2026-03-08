package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_10539 extends BaseMapProcess
   {
      
      private var mcMapAnim:MovieClip;
      
      public function MapProcess_10539()
      {
         super();
      }
      
      protected static function onClickHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var name:String = event.target.name;
         if(name == "btnLeiyi")
         {
            NpcDialog.show(NPC.LEIYI,[MainManager.actorInfo.nick + "想见证我超进化后的实力吗？我愿意接受你的挑战！"],["立刻挑战雷伊","让我准备一下！"],[function():void
            {
               MapManager.changeMap(1003);
            }]);
         }
         else if(name == "btnBlack")
         {
            NpcDialog.show(NPC.BULAIKE_NEW,[MainManager.actorInfo.nick + "想见证我超进化后的实力吗？我愿意接受你的挑战！"],["立刻挑战布莱克","让我准备一下！"],[function():void
            {
               MapManager.changeMap(1002);
            }]);
         }
         else if(name == "btnKaxiusi")
         {
            ModuleManager.showModule(ClientConfig.getAppModule("KaxiusiEvoSummaryPanel"),"正在努力打开面板...");
         }
         else if(name == "btnGaiya")
         {
            NpcDialog.show(NPC.GAIYA,[MainManager.actorInfo.nick + "想见证我超进化后的实力吗？我愿意接受你的挑战！"],["立刻挑战盖亚","让我准备一下！"],[function():void
            {
               MapManager.changeMap(998);
            }]);
         }
         else if(name == "btnMiusi")
         {
            NpcDialog.show(NPC.MIUSI,[MainManager.actorInfo.nick + "想见证我的实力吗？我愿意接受你的挑战！"],["立刻挑战缪斯","让我准备一下！"],[function():void
            {
               MapManager.changeMap(82);
            }]);
         }
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("战神联盟集结","进入雷霆之境",StatManager.USER_CHARACTER);
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_10539_0"),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            btnLevel.addChild(mc);
            mc.gotoAndStop(1);
            mcMapAnim = mc;
            mcMapAnim.addEventListener(MouseEvent.CLICK,onClickHandler);
            AnimateManager.playMcEndHandler(mc.mc,function():void
            {
               mc.gotoAndStop(2);
            });
         });
      }
      
      override public function destroy() : void
      {
         if(this.mcMapAnim)
         {
            this.mcMapAnim.removeEventListener(MouseEvent.CLICK,onClickHandler);
            this.mcMapAnim = null;
         }
      }
   }
}

