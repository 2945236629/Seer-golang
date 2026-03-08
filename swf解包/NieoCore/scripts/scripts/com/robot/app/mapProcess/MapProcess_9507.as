package com.robot.app.mapProcess
{
   import com.robot.app.spt.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import flash.events.*;
   
   public class MapProcess_9507 extends BaseMapProcess
   {
      
      public function MapProcess_9507()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86067738);
         this.topLevel.mouseEnabled = false;
         this.topLevel.mouseChildren = false;
         conLevel["bulaikeNPC"]["signMC"].visible = false;
         conLevel["suolante"].visible = false;
         conLevel["bulaikeNPC"].buttonMode = true;
         conLevel["bulaikeNPC"].addEventListener(MouseEvent.CLICK,this.bulaikeNPCHandler);
      }
      
      private function bulaikeNPCHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(NPC.BULAIKE_NEW,["我一定会让光明重返格雷斯星！"],["与布莱克对战。","算了，我还是先围观吧。"],[function():void
         {
            NpcDialog.show(NPC.BULAIKE_NEW,["作为光明圣坛守护者，我不畏惧任何挑战！但我认为只有一对一的决斗才能证明谁是真正的强者！你有这个胆量吗？"],["OK，我会让你心服口服的！","嘿嘿！让哥哥我再考虑考虑。"],[function():void
            {
               FightBossController.fightBoss("布莱克");
            }]);
         }]);
      }
      
      override public function destroy() : void
      {
         if(Boolean(conLevel["bulaikeNPC"]))
         {
            conLevel["bulaikeNPC"].removeEventListener(MouseEvent.CLICK,this.bulaikeNPCHandler);
         }
      }
   }
}

