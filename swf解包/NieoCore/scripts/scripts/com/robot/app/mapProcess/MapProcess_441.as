package com.robot.app.mapProcess
{
   import com.robot.app.buyItem.*;
   import com.robot.app.spt.*;
   import com.robot.core.event.*;
   import com.robot.core.info.clothInfo.PeopleItemInfo;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class MapProcess_441 extends BaseMapProcess
   {
      
      private var _isEquip:Boolean;
      
      private var _isInitTask:Boolean;
      
      private var sptBtn:MovieClip;
      
      public function MapProcess_441()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["jump"].stop();
         topLevel["camera"].visible = false;
         conLevel["jump"].visible = false;
         conLevel["shadow"].visible = false;
         conLevel["mud"].visible = false;
         conLevel["animate"].visible = false;
         ItemManager.addEventListener(ItemEvent.CLOTH_LIST,function(param1:ItemEvent):void
         {
            ItemManager.removeEventListener(ItemEvent.CLOTH_LIST,arguments.callee);
            if(ItemManager.getClothIDs().indexOf(100564) == -1)
            {
               ItemAction.buyItem(100564,false);
            }
         });
         ItemManager.getCloth();
         this.checkCloth();
         this.addSPT();
      }
      
      private function addSPT() : void
      {
         this.sptBtn = conLevel["sptBtn"];
         this.sptBtn.mouseChildren = false;
         this.sptBtn.mc1.gotoAndPlay(1);
         this.sptBtn.mc2.gotoAndStop(1);
         this.sptBtn.mc1.visible = true;
         this.sptBtn.mc2.visible = false;
         this.sptBtn.buttonMode = true;
         this.sptBtn.addEventListener(MouseEvent.CLICK,this.sptBtnClick);
      }
      
      private function sptBtnClick(param1:MouseEvent) : void
      {
         this.sptBtn.removeEventListener(MouseEvent.CLICK,this.sptBtnClick);
         this.sptBtn.mc1.visible = false;
         this.sptBtn.mc2.visible = true;
         this.sptBtn.mc1.gotoAndStop(1);
         this.sptBtn.mc2.gotoAndPlay(1);
         this.sptBtn.addEventListener(MouseEvent.CLICK,this.sptClick);
      }
      
      private function sptClick(param1:MouseEvent) : void
      {
         if(this.sptBtn.mc2.currentFrame == this.sptBtn.mc2.totalFrames)
         {
            this.sptBtn.removeEventListener(MouseEvent.CLICK,this.sptClick);
            this.sptBtn.addEventListener(MouseEvent.CLICK,this.sptBtnClick);
            FightBossController.fightBoss("肯佩德");
            this.sptBtn.mc1.visible = true;
            this.sptBtn.mc1.gotoAndPlay(1);
            this.sptBtn.mc2.visible = false;
         }
      }
      
      private function removeSpt() : void
      {
         this.sptBtn.addEventListener(MouseEvent.CLICK,this.sptBtnClick);
         this.sptBtn.removeEventListener(MouseEvent.CLICK,this.sptBtnClick);
      }
      
      private function onClothChange(param1:Event) : void
      {
         this.checkCloth();
      }
      
      private function checkCloth() : void
      {
         var _loc1_:PeopleItemInfo = null;
         this._isEquip = false;
         for each(_loc1_ in MainManager.actorInfo.clothes)
         {
            if(_loc1_.id == 100564)
            {
               this._isEquip = true;
               break;
            }
         }
         topLevel["fog"].visible = !this._isEquip;
         if(Boolean(this._isEquip) && !this._isInitTask)
         {
            this._isInitTask = true;
            conLevel["jump"].play();
            topLevel["camera"].visible = true;
            conLevel["jump"].visible = true;
            conLevel["shadow"].visible = true;
            conLevel["mud"].visible = true;
            conLevel["animate"].visible = true;
         }
      }
      
      override public function destroy() : void
      {
         MainManager.actorModel.removeEventListener(PeopleActionEvent.CLOTH_CHANGE,this.onClothChange);
         this.removeSpt();
      }
   }
}

